From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] do not ignore attribute 'noreturn'...
Date: Mon, 14 Sep 2009 19:32:12 +0200
Message-ID: <200909141932.12684.kdudka@redhat.com>
References: <200908282330.08332.kdudka@redhat.com> <70318cbf0908281444q735b7b9fm73f0fcbdbaeefa7b@mail.gmail.com> <70318cbf0909141027y69ddecc2y591ffb6aca300fca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14125 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbZINRdM (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Sep 2009 13:33:12 -0400
In-Reply-To: <70318cbf0909141027y69ddecc2y591ffb6aca300fca@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Monday 14 of September 2009 19:27:40 Christopher Li wrote:
> On Fri, Aug 28, 2009 at 2:44 PM, Christopher Li <sparse@chrisli.org> wrote:
> > Yes, no return is kind of useful. I think we need to do some thing about
> > the MOD_XXX eventually. It is very easy to run out of bits there.
>
> Ah, the MOD_NORETURN is bigger than size of long in 32 bit systems.
> I just get a few warning from GCC.
>
> I just relocate the MOD_NORETURN bits.

Thanks! It makes sense to me.

As for the long term solution, I don't think it's possible without breaking 
the current API/ABI. What about using a bitfield instead? I can see it solved 
this way in <gcc/tree.h>.

Kamil
