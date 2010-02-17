From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: enum warning patch (was Re: Defect in linearization of short circuit &&)
Date: Wed, 17 Feb 2010 15:00:26 +0100
Message-ID: <201002171500.27119.kdudka@redhat.com>
References: <4B77FD0F.50401@googlemail.com> <201002162118.28516.kdudka@redhat.com> <70318cbf1002161444m6daa6a9dh7f30d347b4e9ebbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933526Ab0BQOBT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Feb 2010 09:01:19 -0500
In-Reply-To: <70318cbf1002161444m6daa6a9dh7f30d347b4e9ebbb@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Tue February 16 2010 23:44:08 Christopher Li wrote:
> Most simple enum declare has very small set of values. So naturally I
> might want to use
> some thing smaller than int type to store the enum value. I can't find
> a good way to play
> well with the enum warnings.
> 
> If I use "char type" to store it. It trigger warning when you assign to it.
> If I use "enum foo_type type:8" to store it, it will use int type
> alignment and padding which
> defeat the purpose of using a smaller type.
> 
> Any suggestion?

I don't think it's that easy to implement while keeping it enough generic.  
You need either a type able to store _any_ enum value, or a kind of type
with variable size to keep it still working.  The second seems like quite
a lot of fuss over 4 bytes of memory.

Kamil
