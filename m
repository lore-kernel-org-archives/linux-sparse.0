From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/36] build: make PREFIX overwritable from the
 environment
Date: Sun, 5 Nov 2017 12:30:00 -0800
Message-ID: <20171105203000.ex2bpw4aoyiz4e7j@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-1-luc.vanoostenryck@gmail.com>
 <20171105174408.33uctnzyt53ig2uv@s>
 <df71c48a-f4d4-7654-a15e-3e46c77197c9@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57521 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdKEUaF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 15:30:05 -0500
Content-Disposition: inline
In-Reply-To: <df71c48a-f4d4-7654-a15e-3e46c77197c9@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org

On Sun, Nov 05, 2017 at 07:54:52PM +0100, Uwe Kleine-König wrote:
> Hello Josh,
> 
> On 11/05/2017 06:44 PM, Josh Triplett wrote:
> > On Sun, Nov 05, 2017 at 05:25:09PM +0100, Luc Van Oostenryck wrote:
> >> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> >>
> >> This way I can just use
> >>
> >> 	env PREFIX=/usr make install
> >>
> >> on the command line to install sparse into the system.
> > 
> > You can already use "make PREFIX=/usr install" to do this, which seems
> > far more conventional, and seems less error-prone (e.g. it won't pick up
> > something random from the environment, only something intentionally put
> > on the command line).
> 
> Having PREFIX in the build environment and then being surprised that
> it's picked up by a build isn't something I'd show consideration for.

I could *imagine* it happening by way of using that variable as an
intermediate step in, say, .bashrc, and not unsetting it; I don't know
offhand of any other package that would be affected by it, since most
use things like autotools and cmake that would not pick it up by the
environment.

I'm not saying that this is common, just that picking something up from
the environment seems marginally more error-prone.
