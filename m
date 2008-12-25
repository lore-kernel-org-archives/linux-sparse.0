From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH] Warn about explicit usage of sizeof(void)
Date: Thu, 25 Dec 2008 10:48:41 -0800
Message-ID: <70318cbf0812251048lfe688a0j1977ea2b8161af79@mail.gmail.com>
References: <70318cbf0812241809h158e8767k30dce82acd886ffa@mail.gmail.com>
	 <4953C17B.8060803@numba-tu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:6984 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYLYSsm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Dec 2008 13:48:42 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3278855rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 25 Dec 2008 10:48:41 -0800 (PST)
In-Reply-To: <4953C17B.8060803@numba-tu.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tommy Thorn <tommy@numba-tu.com>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

On Thu, Dec 25, 2008 at 9:23 AM, Tommy Thorn <tommy@numba-tu.com> wrote:
> Christopher Li wrote:
>>
>> So here is what I got. A patch address both of our need. It gives warning
>> of using sizeof(void) explicitly. void* + offset will continue to work
>> without
>> warnings. It will also make is_byte_type() continue to work as it was
>> before.
>>
>> Here is my test script:
>>
>> void *p;
>>
>> int i = sizeof(void);
>> int j = sizeof(*p);
>>
>
> I can't test it right now, but does it give a warning for both sizeof's
> above? If just first results in a warning, then I think that quite
> reasonable.

It warn for both. They are the same thing. It will be strange warn one
not the other.

But my test run shows that none of the kernel code actually use
sizeof(*p). If they do, I think it desert a warning.

Thanks

Chris
