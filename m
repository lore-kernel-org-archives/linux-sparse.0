From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: L'\0' handling
Date: Fri, 09 Apr 2010 22:28:55 +0200
Message-ID: <4BBF8E07.5030306@redhat.com>
References: <1270738799.2167.7.camel@yura-tl> <4BBDF4C0.8020305@redhat.com>	 <1270741172.2167.9.camel@yura-tl> <4BBDFC28.4080304@redhat.com>	 <r2q70318cbf1004081319yc4bf61ccw252798cb98bc760b@mail.gmail.com>	 <1270758815.2167.13.camel@yura-tl>	 <g2p70318cbf1004081346t11dc0507u28f148c8b0706513@mail.gmail.com>	 <4BBE4368.4080105@redhat.com>	 <i2q70318cbf1004081618j1d677d34q438c89f715515520@mail.gmail.com>	 <4BBEEBE9.7030009@redhat.com> <s2m70318cbf1004091307q1f1ec7a6h679452199c9cbf06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19575 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755376Ab0DIU3f (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Apr 2010 16:29:35 -0400
In-Reply-To: <s2m70318cbf1004091307q1f1ec7a6h679452199c9cbf06@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 04/09/2010 10:07 PM, Christopher Li wrote:
> On Fri, Apr 9, 2010 at 1:57 AM, Michael Stefaniuc<mstefani@redhat.com>  wrote:
>> Christopher Li wrote:
>>> On Thu, Apr 8, 2010 at 1:58 PM, Michael Stefaniuc<mstefani@redhat.com>  wrote:
>>>> I have looked at the patch but I don't see it handle wchar_t string literals
>>>> like L"Hello World\n".
>>>
>>> That is on purpose. L"Hello worlds" is very questionable.
>> Huh? Care to explain this one? That is a valid wide char string literal
>> in C and sparse doesn't support those. I don't see much point in
>> supporting only wide char literals and not the wide char string literals.
>
> Ah, silly me. I did not realized the nature of this change is to support wide
> char literals. Just look up what wide char string literals is, now I
> have a better
> idea. You are right. We should support both. My previous patch is wrong
> to set the type of wide char string as "long" type.
>
> So L"hello word\n" pointer are incompatible with char * pointer right?
Yes, they are incompatible.

> And the wchar_t is implementation specific. I am wondering should I just
> pick 16 bit or 32 bit in sparse. Maybe just make it compatible with what
> gcc does.
I know only about Windows that has 16bit wide chars; the rest seems to 
be all 32bit.

gcc supports -fshort-wchar to have the wide chars be 16bit; primary 
consumer of that is mingw; for probably everything else it is useless.

> Obviously, it need more patches to support wide char string literals.
Yeah, that's what I remember from having looked back then at sparse. 
Luckily the correct fix for Wine was to remove the wide char literals :)

bye
	michael
