From: Octavian Purdila <tavi@cs.pub.ro>
Subject: Re: Interrupt context
Date: Tue, 25 Mar 2008 03:34:30 +0200
Message-ID: <200803250334.30713.tavi@cs.pub.ro>
References: <3581ed890803231444i58cff10i408dc4d9bef7b184@mail.gmail.com> <70318cbf0803241400m46d30098g85a402e6e0f86130@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from prof.cs.pub.ro ([141.85.37.3]:43607 "EHLO mail.cs.pub.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbYCYBrK (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Mar 2008 21:47:10 -0400
In-Reply-To: <70318cbf0803241400m46d30098g85a402e6e0f86130@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Codrin Alexandru Grajdeanu <grcodal@gmail.com>, linux-sparse@vger.kernel.org

On Monday 24 March 2008, Christopher Li wrote:
>
> I don't think two pass is enough. You need to build the call graph
> for pretty much every function. Because the irq handler function might
> call other function which calls other function which calls schedule().
>
> I don't think you can go very far without doing any control flow
> and data flow analyze. e.g. kmalloc() can go to sleep or not depend
> on the allocation flag (GFP_ATOMIC).
>
> Which points back to the proposal of:
> a) allow sparse to access  function from different files.
> b) building the call graph for every function in the kernel.
>


Hi Chris,

Yes, you are right, we need to have the complete call graph of the whole 
kernel and kernel modules we want to check. We developed a prototype 
some time ago, but we never manage to move from the prototype to something 
that could be used out in the real world.

The idea which we explored for the prototype was to serialize the sparse state 
and save it into the object files in a private section. The linker would than 
take care of aggregating the sparse state into the kernel image or kernel 
modules. The second stage loads the saved state, create the call graph, 
propagate the interrupt/softirq context around and finally check if schedule 
was called from interrupt context -- the check itself was really broad as we 
did not do any data flow analysis.

The nice thing about this approach is that at least in theory would allow all 
sorts of global analysis, not only this particular (sleeping in interrupt) 
check. And we actually started with the idea of using sparse itself to 
generate the serializer, but we ended up patching the generate code 
manually - we abandoned the idea of adding sparse annotations to sparse code 
to get things right as we realized that we are moving away from our goal.

But, what we obtain after the first stage was a vmlinux over 2GB in size, 
which could not be processed by ELF utilities (we assumed that we hit some 
limitations in the ELF32 format). So in the end its not so practical.

For this second try, we were thinking about replacing the serializer with a 
thiner layer which would just save the call graph information together with 
the associated interrupt context function / sleeping function attributes in 
the object files. 

Any comments / suggestions are greatly appreciated.

Thanks,
tavi







-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

