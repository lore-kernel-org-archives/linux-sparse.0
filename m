From: Christopher Li <sparse@chrisli.org>
Subject: Re: Reduced call graph
Date: Thu, 17 Nov 2011 19:12:10 -0800
Message-ID: <CANeU7QnhCa5rdL4qgjiZKJdpHYzTrzEHEJDi+ytjchANcCa8Wg@mail.gmail.com>
References: <CACsJy8A2X0WukKXerJAN6pxARoGSh1O=8FM+iTZL-xzDCQ1W=w@mail.gmail.com>
	<CANeU7Qns9GDx=XtiEzBph-3gq7WKX+uZMyVu7y3GETzAenFEVg@mail.gmail.com>
	<CACsJy8BDYEx4-G2G-PEL3Q69pdBWwndE=Uyx5rV-pYPg570ZOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58893 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab1KRDML (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Nov 2011 22:12:11 -0500
Received: by yenq3 with SMTP id q3so1965248yen.19
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2011 19:12:10 -0800 (PST)
In-Reply-To: <CACsJy8BDYEx4-G2G-PEL3Q69pdBWwndE=Uyx5rV-pYPg570ZOA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Nov 17, 2011 at 5:14 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>
> Thanks. Can I trace function callbacks too? I think it involves
> keeping track of callbacks until they are called..

Yes and no. You can enumerate the access list and find the
function pointer symbol. You can also find the instruction that
call to the function pointer.

However, that does not tell you want value is in that function
pointer. You need to do date flow analyze to find out the
value in the function pointer. In other words, exactly which function
it is call to. If the pointer is load from memory, it is very hard
to trace. That pointer value can be overwritten by any code.

Chris
