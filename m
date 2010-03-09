From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Mon, 8 Mar 2010 21:43:09 -0800
Message-ID: <70318cbf1003082143n15e88111haee15d2aa027c0b@mail.gmail.com>
References: <1268097872.16227.10.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43819 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab0CIFnK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Mar 2010 00:43:10 -0500
Received: by pwj3 with SMTP id 3so61218pwj.19
        for <linux-sparse@vger.kernel.org>; Mon, 08 Mar 2010 21:43:09 -0800 (PST)
In-Reply-To: <1268097872.16227.10.camel@mj>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org, Kamil Dudka <kdudka@redhat.com>

On Mon, Mar 8, 2010 at 5:24 PM, Pavel Roskin <proski@gnu.org> wrote:
> Hello!
>
> Sparse crashed when checking drivers/net/wireless/ath/ath9k/gpio.c in
> Linux. =A0I could reduce the crash to the following simple program:
>
> enum kind {
> =A0 =A0GOOD
> };
> static void foo(enum kind k)
> {
> }
> static void bar(int ok, int k)
> {
> =A0 =A0foo(ok ? GOOD : k);
> }
>
Confirm. This is cause by the recent enum-warning patch. Without it the=
 sparse
runs fine.

Let me see if this is some thing easy to fix.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
