From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Wed, 1 Feb 2012 16:09:43 -0800
Message-ID: <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42817 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751593Ab2BBAJo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 19:09:44 -0500
Received: by lagu2 with SMTP id u2so978181lag.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 16:09:43 -0800 (PST)
In-Reply-To: <1328090152-28299-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@redhat.com>

On Wed, Feb 1, 2012 at 1:55 AM, Pekka Enberg <penberg@kernel.org> wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> On Tue, Aug 30, 2011 at 10:43 AM, Jeff Garzik <jeff@garzik.org> wrote:
>> * if someone knows how to access a function declaration, I can solve the
>> varargs problem
>
> Hmm. Right now we do not have access to the function declaration at
> linearize time. We've checked that the arguments match, and we've cast
> the arguments to the right types (evaluate.c), so the thinking was
> that you just use the arguments as-is.

Ok, this patch definitely works. However, I think there is ways to get the
type without this patch. The more general question is, how to get type of
any given pseudo register. Currently it is a bit twisted but that information
should be accessible. I believe that has been discuss on the mail list
before. That is why we have insn->type. LLVM want to know every type
of every value in the back end any way. If we are going to do proper
llvm style "get element pointer" in the back end, we need to access type
of every pesudo register.

The current twisted way to get type from the pseudo register is some thing like
this (totally untested code):

swtich (pseudo->type) {
     case PSEDUO_REG:
          return pseudo->def->type;
     case PSEUDO_ARG:
     case PSEUDO_SYMBOL:
          return psuedo->symbol;
     ....

}

Now think about it for a little bit, instead of this patch, how about
I make a counter RFC:

Move the insn->type into pseudo->type. Then you can use use
pseudo->type to access
the type of any pseudo. I estimate the memory usage should be similar,
if not smaller.
It make the pesudo struct larger, however, it make the insn struct
smaller. There is more
instruction than pesudo register in general, because not all
instruction resulting an output
pesudo register. Even consider some pseudo does not generate from
instructions, it is
likely a saving in memory foot print overall.

The plus side, you can have easy access of type for all pseudo. We
might able to get
rid of insn->size as well. Over all I feel it is cleaner.

Suggestions and feed back please?

Chris
