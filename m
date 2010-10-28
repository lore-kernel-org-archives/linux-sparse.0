From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: bad asm goto ?
Date: Wed, 27 Oct 2010 19:45:31 -0700
Message-ID: <AANLkTim6DeB4BAxQv87-mjLjabGrHKY1z+roEuHDznbF@mail.gmail.com>
References: <20101025213145.GA1822@redhat.com>
	<AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
	<20101025223957.GA5561@redhat.com>
	<AANLkTi=r6U3CVS5Br5ZTVVyNEfKzhqTcKkEk5+itwNe1@mail.gmail.com>
	<AANLkTik3OLbW=sM1PFi8uazBHiJbPD06d0ns2z0DQzzN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61126 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778Ab0J1Cpc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Oct 2010 22:45:32 -0400
Received: by iwn10 with SMTP id 10so1788212iwn.19
        for <linux-sparse@vger.kernel.org>; Wed, 27 Oct 2010 19:45:31 -0700 (PDT)
In-Reply-To: <AANLkTik3OLbW=sM1PFi8uazBHiJbPD06d0ns2z0DQzzN@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

On Mon, Oct 25, 2010 at 8:10 PM, Christopher Li <sparse@chrisli.org> wrote:
> It seems that the error is not from the goto. It is from the malformed
> asm_clobber.
> For empty asm_clobber list, sparse currently add nil expr into the
> list. Evaluate will
> complain about the nil pointer thinking it has a bad type.
>
> Any way, this patch should fix it.
>
> Please let me know that help you or not. I am going to apply it after
> the 0.4.3 release.
>

I'm afraid this didn't solve it for me when applying on top of v0.4.3,
if you have any other patches to try,
I'd be glad to test them out.

Harvey
