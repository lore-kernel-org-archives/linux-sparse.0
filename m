From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] compiler.h, sparse, smatch: Do not define
 COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
Date: Sat, 7 Jul 2018 00:46:01 +0200
Message-ID: <20180706224600.cerzr5p5yyorqttw@ltop.local>
References: <20180705155726.26716-1-bart.vanassche@wdc.com>
 <20180706173120.4pg5wwtuqggl6sah@ltop.local>
 <e18b8d7326e41cb858ce1e892664489f8aba995b.camel@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e18b8d7326e41cb858ce1e892664489f8aba995b.camel@wdc.com>
Sender: stable-owner@vger.kernel.org
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "keescook@chromium.org" <keescook@chromium.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "sparse@chrisli.org" <sparse@chrisli.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Jul 06, 2018 at 05:38:33PM +0000, Bart Van Assche wrote:
> 
> Hello Luc,
> 
> Thanks, I had missed Miroslav's patch. BTW, which sparse repository do you
> recommend that I pull from to obtain a recent and stable version of sparse? The
> git://git.kernel.org/pub/scm/devel/sparse/sparse.git repository mentioned on
> https://sparse.wiki.kernel.org/index.php/Main_Page, https://github.com/lucvoo/sparse
> or https://github.com/lucvoo/sparse-dev?
> 
> Thanks,

The tree at:
	https://github.com/lucvoo/sparse-dev
is my own development/work-in-progrees tree. It mainly contains
my WIP topic branches. These branches are not stable and are rebased.
I mainly use this tree to share patch series for testing & review.

The official tree is the one on kernel.org:
	git://git.kernel.org/pub/scm/devel/sparse/sparse.git
and is stable and relatively recent but:
1) it lacks some essential patches to avoid tons of useless noises,
   like for example the patch:
	https://patchwork.kernel.org/patch/10334355/
2) it lacks numerous fixes and improvements, like these overflow
   builtins, but many others too.
3) Christopher, the maintainer, is AWOL since a few months. He even
   never sent an announcement for the last release.

So, I collect patches from myself and from others in the tree:
	  git://github.com/lucvoo/sparse.git
	https://github.com/lucvoo/sparse
This tree is stable, very well tested, never rebased and contains 
numerous fixes and improvements.

Of course, ideally, my stable tree should be merged into the official
tree, like Linus already asked Chris to do (twice). But for now,
I strongly suggest to use my stable & up-to-date tree on github:
	git://github.com/lucvoo/sparse.git

Sorry if the situation is a bit confusing. I'm far from being satisfied
with it myself.

-- Luc Van Oostenryck
