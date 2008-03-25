From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Interrupt context
Date: Mon, 24 Mar 2008 19:57:07 -0700
Message-ID: <70318cbf0803241957l6b211d34t3cad51d587192501@mail.gmail.com>
References: <3581ed890803231444i58cff10i408dc4d9bef7b184@mail.gmail.com>
	 <70318cbf0803241400m46d30098g85a402e6e0f86130@mail.gmail.com>
	 <200803250334.30713.tavi@cs.pub.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:41065 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYCYC5J (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Mar 2008 22:57:09 -0400
Received: by an-out-0708.google.com with SMTP id d31so759316and.103
        for <linux-sparse@vger.kernel.org>; Mon, 24 Mar 2008 19:57:07 -0700 (PDT)
In-Reply-To: <200803250334.30713.tavi@cs.pub.ro>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Octavian Purdila <tavi@cs.pub.ro>
Cc: Codrin Alexandru Grajdeanu <grcodal@gmail.com>, linux-sparse@vger.kernel.org

On Mon, Mar 24, 2008 at 6:34 PM, Octavian Purdila <tavi@cs.pub.ro> wrote:
> On Monday 24 March 2008, Christopher Li wrote:
>  Yes, you are right, we need to have the complete call graph of the whole
>  kernel and kernel modules we want to check. We developed a prototype
>  some time ago, but we never manage to move from the prototype to something
>  that could be used out in the real world.

Interesting. I did some hack on the serialize of the sparse output as well.

>  The idea which we explored for the prototype was to serialize the sparse state
>  and save it into the object files in a private section. The linker would than
>  take care of aggregating the sparse state into the kernel image or kernel
>  modules. The second stage loads the saved state, create the call graph,
>  propagate the interrupt/softirq context around and finally check if schedule
>  was called from interrupt context -- the check itself was really broad as we
>  did not do any data flow analysis.
>
>  The nice thing about this approach is that at least in theory would allow all
>  sorts of global analysis, not only this particular (sleeping in interrupt)
>  check. And we actually started with the idea of using sparse itself to
>  generate the serializer, but we ended up patching the generate code
>  manually - we abandoned the idea of adding sparse annotations to sparse code
>  to get things right as we realized that we are moving away from our goal.

I want to have sparse generate the the serializer code as well. One problem
I run into is that, a lot of the sparse C structure member are within the
union. The serialize code needs to understand the object type in order to access
the member specific to this type inside the union. It need some fairly
complicate
data flow analyze code to trace the sparse code itself how it access the union
member. I end up do it by hand as well :-)

>
>  But, what we obtain after the first stage was a vmlinux over 2GB in size,
>  which could not be processed by ELF utilities (we assumed that we hit some
>  limitations in the ELF32 format). So in the end its not so practical.

My plan is to write a symbol mapping  to perform the symbol look up.
For each extern symbol, you can look up to a object file name and an offset
within that object file to locate the symbol.

Then with the help from the serializer, you can load the that object file
into memory.

BTW, besides linking what else do the ELF format buys you?

Whatever file format, I want it to store the linearized byte code rather
than the machine code.

>  For this second try, we were thinking about replacing the serializer with a
>  thiner layer which would just save the call graph information together with
>  the associated interrupt context function / sleeping function attributes in
>  the object files.

I would like to see some thing more general. For each file, it saves
the information:

1) What symbol does it provide as extern.
2) What symbol does it accessed.
3) The linearized byte code for each function emits. (serialized of
the entrypoint
    for each function).

And then, you would be able to perform a lot of checking on this.

Chris
