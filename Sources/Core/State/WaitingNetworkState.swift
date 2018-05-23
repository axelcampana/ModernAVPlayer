//
//  WaitingNetworkState.swift
//  ModernAVPlayer
//
//  Created by raphael ankierman on 18/05/2018.
//

import AVFoundation
import Foundation

public final class WaitingNetworkState: PlayerState {
    
    // MARK: - Inputs
    
    public unowned var context: PlayerContext
    private var reachability: ReachabilityServiceProtocol
    
    // MARK: - Init
    
    public init(context: PlayerContext,
                urlToReload: URL,
                shouldPlaying: Bool,
                error: CustomError,
                reachabilityService: ReachabilityServiceProtocol? = nil) {
        LoggerInHouse.instance.log(message: "Init", event: .debug)
        self.context = context
        self.reachability = reachabilityService ?? ReachabilityService(config: context.config)
        setupReachabilityCallbacks(shouldPlaying: shouldPlaying, urlToReload: urlToReload, error: error)
        reachability.start()
    }
    
    deinit {
        LoggerInHouse.instance.log(message: "Deinit", event: .debug)
    }
    
    // MARK: - Reachability
    
    private func setupReachabilityCallbacks(shouldPlaying: Bool, urlToReload: URL, error: CustomError) {
        reachability.isTimedOut = { [weak self] in
            guard let strongSelf = self else { return }
            
            let failedState = FailedState(context: strongSelf.context, error: error)
            self?.context.changeState(state: failedState)
        }
        
        reachability.isReachable = { [weak self] in
            guard let strongSelf = self else { return }
            
            let lastKnownPosition = strongSelf.isDurationItemFinite() ? strongSelf.context.player.currentTime() : nil
            let state = LoadingMediaState(context: strongSelf.context,
                                          itemUrl: urlToReload,
                                          shouldPlaying: shouldPlaying,
                                          lastPosition: lastKnownPosition)
            strongSelf.context.changeState(state: state)
        }
    }
    
    private func isDurationItemFinite() -> Bool {
        return context.itemDuration?.isFinite ?? false
    }
    
    // MARK: - Shared actions
    
    public func loadMedia(media: PlayerMedia, shouldPlaying: Bool) {
        let state = LoadingMediaState(context: context, media: media, shouldPlaying: shouldPlaying)
        context.changeState(state: state)
    }
    
    public func pause() {
        context.changeState(state: PausedState(context: context))
    }
    
    public func play() {
        let debug = "Unable to play, reload a media first"
        context.debugMessage = debug
        LoggerInHouse.instance.log(message: "Unable to play, reload a media first", event: .warning)
    }
    
    public func seek(position: Double) {
        let debug = "Unable to seek, load a media first"
        context.debugMessage = debug
        LoggerInHouse.instance.log(message: "Unable to seek, load a media first", event: .warning)
    }
    
    public func stop() {
        context.changeState(state: StoppedState(context: context))
    }
}