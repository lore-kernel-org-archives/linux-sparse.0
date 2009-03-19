From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Nasal demons in preprocessor use (Re: [PATCH] test-suite: new
	preprocessor test case)
Date: Thu, 19 Mar 2009 20:27:58 +0100
Message-ID: <20090319192758.GB24318@elte.hu>
References: <20090319175544.13691.42362.stgit@f10box.hanneseder.net> <20090319182628.GB28946@ZenIV.linux.org.uk> <154e089b0903191151q37ab7b20o43838845af12966f@mail.gmail.com> <20090319190730.GC28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759880AbZCST2W@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090319190730.GC28946@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Hannes Eder <hannes@hanneseder.net>, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org


* Al Viro <viro@ZenIV.linux.org.uk> wrote:

> On Thu, Mar 19, 2009 at 07:51:22PM +0100, Hannes Eder wrote:
> > When currently running sparse agains the current linux-next tree, a
> > lot of checks produce error messages like this:
> > 
> > include/linux/skbuff.h:381:9: error: expected preprocessor identifier
> 
> Cute.  If anything, this kmemcheck_define_bitfield stuff needs to be moved
> inside the ifdefs.
> 
> Folks, this is not a valid C, period.  And no, there's no promise 
> that gcc won't change its behaviour on such constructs whenever 
> they feel like that.
> 
> Preprocessor directives do not belong in argument lists.  Not 
> #ifdef, not #define, not #include; this is undefined behaviour.

Agreed.

Vegard, it's this bit:

        kmemcheck_define_bitfield(flags2, {
#ifdef CONFIG_IPV6_NDISC_NODETYPE
                __u8                    ndisc_nodetype:2;
#endif
#if defined(CONFIG_MAC80211) || defined(CONFIG_MAC80211_MODULE)
                __u8                    do_not_encrypt:1;
                __u8                    requeue:1;
#endif
        });

	Ingo
