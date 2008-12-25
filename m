From: Tommy Thorn <tommy@numba-tu.com>
Subject: Re: [PATCH] Warn about explicit usage of sizeof(void)
Date: Thu, 25 Dec 2008 09:23:07 -0800
Message-ID: <4953C17B.8060803@numba-tu.com>
References: <70318cbf0812241809h158e8767k30dce82acd886ffa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from server204.webhostingpad.com ([69.65.0.218]:56354 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751614AbYLYRXQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Dec 2008 12:23:16 -0500
In-Reply-To: <70318cbf0812241809h158e8767k30dce82acd886ffa@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

Christopher Li wrote:
> So here is what I got. A patch address both of our need. It gives warning
> of using sizeof(void) explicitly. void* + offset will continue to work without
> warnings. It will also make is_byte_type() continue to work as it was
> before.
>
> Here is my test script:
>
> void *p;
>
> int i = sizeof(void);
> int j = sizeof(*p);
>   

I can't test it right now, but does it give a warning for both sizeof's 
above? If just first results in a warning, then I think that quite 
reasonable.

Tommy

