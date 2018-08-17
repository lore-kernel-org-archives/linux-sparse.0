From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] linux/compiler.h: don't use bool
Date: Fri, 17 Aug 2018 13:39:35 -0700
Message-ID: <20180817133935.b93ce7534656e587d4c8d3e6@linux-foundation.org>
References: <20180817101036.20969-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817101036.20969-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Fri, 17 Aug 2018 12:10:35 +0200 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Appararently, it's possible to have a non-trivial TU include a few headers,
> including linux/build_bug.h, without ending up with linux/types.h. So
> the 0day bot sent me

What's a "TU"?

> 
> config: um-x86_64_defconfig (attached as .config)
> 
> >> include/linux/compiler.h:316:3: error: unknown type name 'bool'; did you mean '_Bool'?
>       bool __cond = !(condition);    \
> 
> for something I'm working on.
> 
> Rather than contributing to the #include madness and including
> linux/types.h from compiler.h, just use int.
