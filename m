From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: L'\0' handling
Date: Fri, 09 Apr 2010 10:57:13 +0200
Message-ID: <4BBEEBE9.7030009@redhat.com>
References: <1270738799.2167.7.camel@yura-tl> <4BBDF4C0.8020305@redhat.com>	 <1270741172.2167.9.camel@yura-tl> <4BBDFC28.4080304@redhat.com>	 <r2q70318cbf1004081319yc4bf61ccw252798cb98bc760b@mail.gmail.com>	 <1270758815.2167.13.camel@yura-tl>	 <g2p70318cbf1004081346t11dc0507u28f148c8b0706513@mail.gmail.com>	 <4BBE4368.4080105@redhat.com> <i2q70318cbf1004081618j1d677d34q438c89f715515520@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab0DII6E (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Apr 2010 04:58:04 -0400
In-Reply-To: <i2q70318cbf1004081618j1d677d34q438c89f715515520@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Yura Pakhuchiy <pakhuchiy@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On Thu, Apr 8, 2010 at 1:58 PM, Michael Stefaniuc <mstefani@redhat.com> wrote:
>> I have looked at the patch but I don't see it handle wchar_t string literals
>> like L"Hello World\n".
> 
> That is on purpose. L"Hello worlds" is very questionable.
Huh? Care to explain this one? That is a valid wide char string literal
in C and sparse doesn't support those. I don't see much point in
supporting only wide char literals and not the wide char string literals.

bye
	michael

