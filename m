From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Question: attribute 'naked'
Date: Wed, 5 Aug 2009 08:19:36 +0200
Message-ID: <20090805061936.GB2861@merkur.ravnborg.org>
References: <BD79186B4FD85F4B8E60E381CAEE190901B7781D@mi8nycmail19.Mi8.com> <20090804221511.GA17112@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:60193 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932943AbZHEGTg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Aug 2009 02:19:36 -0400
Content-Disposition: inline
In-Reply-To: <20090804221511.GA17112@n2100.arm.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sparse@vger.kernel.org
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, linux-arm-kernel@lists.arm.linux.org.uk

cc: linux-sparse
On Tue, Aug 04, 2009 at 11:15:11PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 04, 2009 at 06:03:22PM -0400, H Hartley Sweeten wrote:
> > When compiling the kernel with sparse, in arch/arm/mm/copypage-v4wb.c
> > I get the following error:
> > 
> > arch/arm/mm/copypage-v4wb.c:25:13: error: attribute 'naked': unknown attribute 
> 
> Sparse doesn't understand the naked attribute.  GCC does.
> 
> > /*
> >  * it doesn't make sense on ARM (currently the only user of __naked) to trace
> >  * naked functions because then mcount is called without stack and frame pointer
> >  * being set up and there is no chance to restore the lr register to the value
> >  * before mcount was called.
> >  */
> > #define __naked				__attribute__((naked)) notrace
> > 
> > Is this macro actually correct?  The compiler I am using is:
> 
> Yes - naked instructions can't be traced, because they tend to have
> entry/exit sequences which mcount won't understand.
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
> 
