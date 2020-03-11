From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Add symantic index utility
Date: Wed, 11 Mar 2020 18:11:57 +0100
Message-ID: <20200311171157.fhpuwphwfn3ek7wm@ltop.local>
References: <20200309152509.6707-1-gladkov.alexey@gmail.com>
 <20200309223701.dbnej7esb4qp56bm@ltop.local>
 <20200310150713.GB19012@redhat.com>
 <20200311090745.GD11561@kadam>
 <20200311113351.GA19327@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33412 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbgCKRMB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Mar 2020 13:12:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id r7so3632575wmg.0
        for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2020 10:12:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200311113351.GA19327@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Wed, Mar 11, 2020 at 12:33:52PM +0100, Oleg Nesterov wrote:
> and just in case... there are other cases when GCC and sparse differ,
> 
> 	if, within a macro invocation, that macro is redefined, then the new
> 	definition takes effect in time for argument pre-expansion, but the
> 	original definition is still used for argument replacement. Here is a
> 	pathological example:
> 
> 		#define f(x) x x
> 		f (1
> 		#undef f
> 		#define f 2
> 		f)
> 
> 	which expands to
> 
> 		1 2 1 2
> 
> ./sparse -E outputs
> 
> 	/tmp/M.c:3:1: error: directive in macro's argument list
> 	/tmp/M.c:4:1: error: directive in macro's argument list
> 	2

Not much, indeed. But I see that sparse & gcc differ also in the
non-erroneous case:
	#define f(x) x x
	f(1
	2)

(Sparse adds newlines after the 1s) but it seems easy to solve.

-- Luc
