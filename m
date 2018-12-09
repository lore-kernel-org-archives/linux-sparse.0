From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Date: Sun, 9 Dec 2018 21:46:00 +0000
Message-ID: <20181209214600.GC2217@ZenIV.linux.org.uk>
References: <20181209204449.18906-1-tycho@tycho.ws>
 <20181209210220.GB2217@ZenIV.linux.org.uk>
 <20181209212523.GE30796@cisco>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209212523.GE30796@cisco>
Sender: linux-kernel-owner@vger.kernel.org
To: Tycho Andersen <tycho@tycho.ws>
Cc: linux-sparse@vger.kernel.org, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sun, Dec 09, 2018 at 02:25:23PM -0700, Tycho Andersen wrote:

> > Which sparse checks do not trigger?  Explain, please - as it is, I had been
> > unable to guess what could "specifically looks for a call instruction" refer
> > to.
> 
> In sparse.c there's check_call_instruction(), which is triggered when
> there's an instruction of OP_CALL type in the basic block. This simply
> compares against the name of the call target to determine whether or
> not to call check_ctu().

Oh, that Linus' experiment with "look for huge constant size argument
to memcpy() et.al."?  Frankly, it's not only the wrong place to put the
checks, but breaking inlining loses the _real_ "known constant size"
checks in there.

I don't know if the check_ctu thing has ever caught a bug...  What kind of
checks do you want to add?  Because this place is almost certainly wrong
for anything useful...

If anything, I would suggest simulating this behaviour with something like
	if (__builtin_constant_p(size) && size > something)
		/* something that would trigger a warning */
_inside_ copy_from_user()/copy_to_user() and to hell with name-recognizing
magic...
