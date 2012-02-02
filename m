From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration accessible
 to backend
Date: Thu, 2 Feb 2012 08:28:49 +0200 (EET)
Message-ID: <alpine.LFD.2.02.1202020828210.1771@tux.localdomain>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>  <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com> <1328144044.28487.91.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56774 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760Ab2BBG3H (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Feb 2012 01:29:07 -0500
Received: by lagu2 with SMTP id u2so1094525lag.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 22:29:05 -0800 (PST)
In-Reply-To: <1328144044.28487.91.camel@pasglop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

On Thu, 2 Feb 2012, Benjamin Herrenschmidt wrote:
> We also should probably store the LLVM Ref of the type once "converted"
> into the original struct symbol so that we don't have to re-create it or
> all the time (thinking especially of typedef'ed function pointers) or
> search for it by name (functions).

Agreed. We already do this for LLVMValueRefs which are stored in ->priv 
field of pseudo_t.
