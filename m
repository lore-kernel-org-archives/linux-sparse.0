From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH 2/15 v2] Unhardcode byte size being 8 bits.
Date: Thu, 18 Dec 2008 01:52:31 +0000
Message-ID: <4949ACDF.50209@knosof.co.uk>
References: <20081217190534.24084.94887.stgit@zaytsev.su>	 <49498C67.4000700@cowlark.com> <f19298770812171633w43707eb0h8c0a0be262549ddf@mail.gmail.com> <4949A306.2060200@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:28995 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750696AbYLRB7L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Dec 2008 20:59:11 -0500
In-Reply-To: <4949A306.2060200@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

All,

> I have reported the bug in gcc.  Track Bug: 38563
> at: gcc.gnu.org/bugzilla

A very prompt response from a gcc maintainer, bug 38563
is a duplicate of bug 22086.

"This is a GCC extension. sizeof(void) is invalid C and should error out
and does with -pedantic-errors"

Yuk, who ever thought to use -pedantic-errors!

-ansi or -std=c89 or -std=c99 don't elicit any diagnostics.

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
