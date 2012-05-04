From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 4 May 2012 08:30:54 -0700
Message-ID: <20120504153054.GA5994@leaf>
References: <4F967865.60809@gaisler.com>
 <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
 <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
 <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
 <4FA38635.5060300@gaisler.com>
 <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
 <4FA3B14A.3070609@gaisler.com>
 <4FA3CD58.80809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33843 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab2EDPbD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 11:31:03 -0400
Content-Disposition: inline
In-Reply-To: <4FA3CD58.80809@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Konrad Eisele <konrad@gaisler.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Fri, May 04, 2012 at 02:36:40PM +0200, Konrad Eisele wrote:
> Take the 2 files b.c and a.h.
> 
> vvvvvv b.c vvvvv
> #define d1
> #include "a.h"
> struct s0 { int x; };
> int main(int a, char **b) {
>   struct s0 v;
>   d2(m);
> };
> ^^^^^^ b.c ^^^^^^
> 
> vvvvvv a.h vvvvv
> #ifdef d2
> #define m v
> #else
> #define m n
> #endif
> 
> #ifdef d1
> #define d2(a) while(a.x) { }
> #endif
> ^^^^^^ a.h ^^^^^^
> 
> Now use sparse and you get:
> $./sparse b.c
> b.c:6:3: error: cannot dereference this type
> 
> The error was that you forgot in b.c:
> +#define d2
>  #define d1
>  ...
> 
> When you have a dependency tree what you can printout is:
> 
> $./sparse b.c
> b.c:6:3: error: cannot dereference this type
>  +macro expansion of d2 defined in a.h:8
>    + defined because of #ifdef d1 in a.h:7
>     + dependent of d1 defined at b.c:1
>  +> argument 0 expansion at b.c:6
>    + macro expansion m defined in a.h:4
>      + defined because of else of #ifdef d2
>        + dependend of d2 (not defined)

That looks wildly useful to me.  I'd love to see that information
available to Sparse somehow, as long as it doesn't significantly impact
the performance of the common case (namely, running sparse on code that
has no warnings or errors).

One idea: could you check the impact of your patch on a Linux kernel
build (with defconfig)?  Try building the kernel with sparse (make C=2),
with and without your patch, and measure the total time.  If your patch
has negligible impact on build time, and it doesn't require changing
every other line of Sparse due to interface changes, it should prove
reasonable.

The other key point: much like Linux, Sparse doesn't normally accept
patches that add a new interface without a patch adding the
corresponding code that uses that interface.  Having an implementation
helps ensure that the design of an interface fits its intended purpose.
For instance, if you could create a simple example of the kind of output
you showed above (even just saying in a warning message "expanded from
macro foo"), perhaps modeled after LLVM's clang error messages, and
include that in a second patch depending on the first, then that
two-patch sequence would have a much better chance of getting in.

Hope that helps,
Josh Triplett
