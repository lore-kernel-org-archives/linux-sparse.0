From: Christopher Li <sparse@chrisli.org>
Subject: Re: L'\0' handling
Date: Thu, 8 Apr 2010 16:18:39 -0700
Message-ID: <i2q70318cbf1004081618j1d677d34q438c89f715515520@mail.gmail.com>
References: <1270738799.2167.7.camel@yura-tl> <4BBDF4C0.8020305@redhat.com>
	 <1270741172.2167.9.camel@yura-tl> <4BBDFC28.4080304@redhat.com>
	 <r2q70318cbf1004081319yc4bf61ccw252798cb98bc760b@mail.gmail.com>
	 <1270758815.2167.13.camel@yura-tl>
	 <g2p70318cbf1004081346t11dc0507u28f148c8b0706513@mail.gmail.com>
	 <4BBE4368.4080105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:42446 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933785Ab0DHXSm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Apr 2010 19:18:42 -0400
Received: by qw-out-2122.google.com with SMTP id 8so996854qwh.37
        for <linux-sparse@vger.kernel.org>; Thu, 08 Apr 2010 16:18:41 -0700 (PDT)
In-Reply-To: <4BBE4368.4080105@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: Yura Pakhuchiy <pakhuchiy@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Apr 8, 2010 at 1:58 PM, Michael Stefaniuc <mstefani@redhat.com> wrote:
>
> I have looked at the patch but I don't see it handle wchar_t string literals
> like L"Hello World\n".

That is on purpose. L"Hello worlds" is very questionable.

Chris
