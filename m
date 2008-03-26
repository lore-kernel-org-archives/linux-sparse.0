From: Octavian Purdila <tavi@cs.pub.ro>
Subject: Re: Interrupt context
Date: Wed, 26 Mar 2008 14:43:18 +0200
Message-ID: <200803261443.18529.tavi@cs.pub.ro>
References: <3581ed890803231444i58cff10i408dc4d9bef7b184@mail.gmail.com> <200803250334.30713.tavi@cs.pub.ro> <70318cbf0803241957l6b211d34t3cad51d587192501@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ixia01.ro.gtsce.net ([212.146.94.66]:2472 "EHLO
	ixro-ex1.ixiacom.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754398AbYCZM6b (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 26 Mar 2008 08:58:31 -0400
In-Reply-To: <70318cbf0803241957l6b211d34t3cad51d587192501@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Codrin Alexandru Grajdeanu <grcodal@gmail.com>, linux-sparse@vger.kernel.org

On Tuesday 25 March 2008, Christopher Li wrote:
>
> BTW, besides linking what else do the ELF format buys you?
>

You don't need to change the build system, you got all the information you 
need in the final deliverable of the build (vmlinux or the kernel module).

>
> >  For this second try, we were thinking about replacing the serializer
> > with a thiner layer which would just save the call graph information
> > together with the associated interrupt context function / sleeping
> > function attributes in the object files.
>
> I would like to see some thing more general. For each file, it saves
> the information:
>
> 1) What symbol does it provide as extern.
> 2) What symbol does it accessed.
> 3) The linearized byte code for each function emits. (serialized of
> the entrypoint
>     for each function).
>
> And then, you would be able to perform a lot of checking on this.
>

OK, so you think that the serializer approach is still the way to go then? 

Thanks,
tavi






