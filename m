From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Ignore the cdecl and stdcall attributes for now.
Date: Wed, 16 May 2007 14:46:23 +0200
Message-ID: <20070516124623.GA29071@uranus.ravnborg.org>
References: <20070515220536.GA23923@redhat.com> <464AA57B.3010205@freedesktop.org> <464AE8BE.9020805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:42845 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824AbXEPMqJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 May 2007 08:46:09 -0400
Content-Disposition: inline
In-Reply-To: <464AE8BE.9020805@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

> 
> >Did you integrate Sparse into the Wine build system, or did you use 
> >CC=cgcc?
> Crude hack in my git tree to Make.rules adding a sparse call to the .c 
> => .o build rule. Tried to see how the Kernel build system integrates 
> that and my  head started to smoke ... . I do not plan to send it 
> upstream for the moment.

If your smoking head has left a few questions about the kernel build 
system feel free to ask.
I have hacked a bit on kbuild so I should be able to help you.

But on the other hand I never looked at the Wine build system.

	Sam
