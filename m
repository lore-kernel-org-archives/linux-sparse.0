From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] do not ignore attribute 'noreturn'...
Date: Mon, 14 Sep 2009 23:13:45 +0200
Message-ID: <200909142313.46077.kdudka@redhat.com>
References: <200908282330.08332.kdudka@redhat.com> <200909142144.37273.kdudka@redhat.com> <70318cbf0909141347p47c8a277ja6f9d18ae3c6fcbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932280AbZINVNx (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Sep 2009 17:13:53 -0400
In-Reply-To: <70318cbf0909141347p47c8a277ja6f9d18ae3c6fcbd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Peringer Petr <peringer@fit.vutbr.cz>

On Monday 14 of September 2009 22:47:40 Christopher Li wrote:
> Can you clarify why do you need to use the UID instead of the pointer of
> symbol? One reason I can see is that if you want to dump the AST tree
> into objects on disk. Other application can read it back and load into
> memory. If the symbol already exist in the memory, you should be able to
> use pointer directly.

The only reason (for now) is that I already use them with the gcc plug-in and 
the code_listener interace is based on them. I don't think it *needs* to be 
implemented in SPARSE since the workaround is easy. I've only raised the idea
in hope such enumeration might be generally useful.

Adding Petr Peringer to CC. He came with UID idea to our project and might be 
able to give us better clarification for that approach.

> BTW, I have code to dump most of the struct into disk already. I think
> I send to the list before. Of course I can create a branch for it. Reading
> is not completed yet.

Thanks! Good to know something like that is available. But I don't think our 
project can gain from this functionality right now.

Kamil
