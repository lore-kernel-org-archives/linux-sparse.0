From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] jffs2: fix sparse errors: directive in argument list
Date: Wed, 20 Nov 2013 15:51:59 -0800
Message-ID: <20131120235159.GA25026@jtriplet-mobl1>
References: <1384719513-27386-1-git-send-email-nunes.erico@gmail.com>
 <1384724403.2727.22.camel@joe-AO722>
 <CAK4VdL2nKEE+xb=HtMGNsMGNR_ivUn_WnLi7X-rrXT0fpGbSTw@mail.gmail.com>
 <1384728305.14335.4.camel@joe-AO722>
 <20131118013349.GM13318@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131118013349.GM13318@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Joe Perches <joe@perches.com>, Erico Nunes <nunes.erico@gmail.com>, linux-sparse@vger.kernel.org, dwmw2 <dwmw2@infradead.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Nov 18, 2013 at 01:33:49AM +0000, Al Viro wrote:
> On Sun, Nov 17, 2013 at 02:45:05PM -0800, Joe Perches wrote:
> > On Sun, 2013-11-17 at 20:34 -0200, Erico Nunes wrote:
> > > Do you mean it as an error in the sparse tool?
> > 
> > Yes.  I think it's a defect in how sparse
> > treats string concatenation.
> > 
> > That style:
> > 
> > 	printk("%s\n",
> > #ifdef FOO
> > 	"foo"
> > #endif
> > #ifdef BAR
> > 	"bar"
> > #endif
> > 	"string");
> > 
> > is pretty common in the kernel sources.
> 
> ... and it's perfectly fine, until somebody starts playing in nasal
> daemon country and do that in *macro* arguments.  And a nasal daemon
> country it is - it's an undefined behaviour.  See 6.10.3p11 in C99.
> And trying to define a semantics for that gets real ugly real fast.
> sparse matches gcc behaviour (I hope), but it warns about such abuses.
> It's a defect, all right - one being reported by sparse.
> 
> Folks, please, RTFStandard if you decide to play clever games with
> preprocessing.  Chapter 6.10 is not particulary long or complicated.
> C99 has improved the preprocessor semantics a whole lot compared to
> the earlier horrible mess (mostly by defining it in terms of token
> stream transformations rather then text ones), but it's still very
> easy to abuse...

And since pr_foo (and the underlying pr_fmt) are already macros, that's
exactly the problem.

- Josh Triplett
