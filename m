From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/5] Makefile: suppress error message from shell
Date: Mon, 20 Jul 2009 13:21:01 -0700
Message-ID: <70318cbf0907201321y26cba10h2d77d7ae02d86090@mail.gmail.com>
References: <4A6233D0.1060502@ramsay1.demon.co.uk>
	 <20090719140316.GB25417@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f202.google.com ([209.85.212.202]:45292 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbZGTUVB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 20 Jul 2009 16:21:01 -0400
Received: by vwj40 with SMTP id 40so409566vwj.33
        for <linux-sparse@vger.kernel.org>; Mon, 20 Jul 2009 13:21:01 -0700 (PDT)
In-Reply-To: <20090719140316.GB25417@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

> On Sat, Jul 18, 2009 at 09:42:56PM +0100, Ramsay Jones wrote:
>> In particular, on systems which do not have 'pkg-config' installed,
>> every invocation of make issues the following message:
>>
>> =A0 =A0 /bin/sh: pkg-config: command not found
>>
>> Suppress the message by redirecting stderr to the bit-bucket.

Applied.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
