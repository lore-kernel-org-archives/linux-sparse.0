From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] do not ignore attribute 'noreturn'...
Date: Mon, 14 Sep 2009 13:47:40 -0700
Message-ID: <70318cbf0909141347p47c8a277ja6f9d18ae3c6fcbd@mail.gmail.com>
References: <200908282330.08332.kdudka@redhat.com>
	 <200909141932.12684.kdudka@redhat.com>
	 <70318cbf0909141055m218d2819m592f9fa72cc26774@mail.gmail.com>
	 <200909142144.37273.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:61613 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092AbZINUri (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Sep 2009 16:47:38 -0400
Received: by vws33 with SMTP id 33so646578vws.33
        for <linux-sparse@vger.kernel.org>; Mon, 14 Sep 2009 13:47:40 -0700 (PDT)
In-Reply-To: <200909142144.37273.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Sep 14, 2009 at 12:44 PM, Kamil Dudka <kdudka@redhat.com> wrote:
> It sounds like a tough challenge to me :-)
>
> I am playing with the SPARSE API now. Any chance to pass in a unique ID
> to each symbol? (as equivalent to DECL_UID from <gcc/tree.h>) I can of course
> manage an ptr/ID mapping at application level. I am only curious if this is

Can you clarify why do you need to use the UID instead of the pointer of
symbol? One reason I can see is that if you want to dump the AST tree
into objects on disk. Other application can read it back and load into
memory. If the symbol already exist in the memory, you should be able to
use pointer directly.

BTW, I have code to dump most of the struct into disk already. I think
I send to the list before. Of course I can create a branch for it. Reading
is not completed yet.

Chris
