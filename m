From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Thu, 02 Feb 2012 11:54:04 +1100
Message-ID: <1328144044.28487.91.camel@pasglop>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	 <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57278 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779Ab2BBAyR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 19:54:17 -0500
In-Reply-To: <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

On Wed, 2012-02-01 at 16:09 -0800, Christopher Li wrote:
> 
> Ok, this patch definitely works. However, I think there is ways to get the
> type without this patch. The more general question is, how to get type of
> any given pseudo register. Currently it is a bit twisted but that information
> should be accessible. I believe that has been discuss on the mail list
> before. That is why we have insn->type. LLVM want to know every type
> of every value in the back end any way. If we are going to do proper
> llvm style "get element pointer" in the back end, we need to access type
> of every pesudo register.

We also should probably store the LLVM Ref of the type once "converted"
into the original struct symbol so that we don't have to re-create it or
all the time (thinking especially of typedef'ed function pointers) or
search for it by name (functions).

Cheers,
Ben.


