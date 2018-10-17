From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] kbuild: Add -Wshadow to sparse
Date: Wed, 17 Oct 2018 22:13:01 +0200
Message-ID: <20181017201300.4er4t3lef7gabgps@linutronix.de>
References: <20181017170554.18841-1-bigeasy@linutronix.de>
 <20181017170554.18841-2-bigeasy@linutronix.de>
 <20181017192501.3yqfq77q2n4xdq7l@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017192501.3yqfq77q2n4xdq7l@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>
List-Id: linux-sparse@vger.kernel.org

On 2018-10-17 21:25:02 [+0200], Luc Van Oostenryck wrote:
> Hi,
Hi,

> I made a quick test and I saw it would add a lot of noise because of
> (valid) warnings coming from macros using a statement expression
> redeclaring variables like '__u', 'tmp', ...
> 
> BTW, as far as I can see, sparse never had it enabled by default.

I must have seen those warnings with C=1 _years_ ago otherwise I
wouldn't know about that feature. Or it was enabled by the check process
and got disabled but I can't find evidence for it.

> Kind regards,
> -- Luc Van Oostenryck

Sebastian
