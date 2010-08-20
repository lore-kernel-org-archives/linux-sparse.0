From: Christopher Li <sparse@chrisli.org>
Subject: Re: [[PATCH]] Fix a typo - "typdef" is neither C nor plain English
Date: Fri, 20 Aug 2010 12:09:24 -0700
Message-ID: <AANLkTinLMp_Fm7EByMj2W6hkPhQocVn5paFhmB7EOo56@mail.gmail.com>
References: <1282304949.10440.234.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53465 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab0HTTJZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Aug 2010 15:09:25 -0400
Received: by eyg5 with SMTP id 5so2378795eyg.19
        for <linux-sparse@vger.kernel.org>; Fri, 20 Aug 2010 12:09:24 -0700 (PDT)
In-Reply-To: <1282304949.10440.234.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-sparse@vger.kernel.org

On Fri, Aug 20, 2010 at 3:36 AM, Bernd Petrovitsch <bernd@sysprog.at> w=
rote:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "[typdef]", "[structof]", "[unionof]", =
"[enum]",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "[typedef]", "[structof]", "[unionof]",=
 "[enum]",

Good catch. I will apply it.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
