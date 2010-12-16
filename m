From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] Fix tokenizer for octal escape sequences
Date: Thu, 16 Dec 2010 11:35:06 -0800
Message-ID: <AANLkTimM3neAiMyq3j_SbuhM=vK+MLL-AvZbmHXoeRVj@mail.gmail.com>
References: <1292490886-6238-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64174 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab0LPTfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 Dec 2010 14:35:07 -0500
Received: by gyb11 with SMTP id 11so1847596gyb.19
        for <linux-sparse@vger.kernel.org>; Thu, 16 Dec 2010 11:35:07 -0800 (PST)
In-Reply-To: <1292490886-6238-1-git-send-email-namhyung@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Dec 16, 2010 at 1:14 AM, Namhyung Kim <namhyung@gmail.com> wrot=
e:
> Don't allow 8 and 9 to be included in octal escape sequences.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (=
next >=3D '0' && next <=3D '9') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (=
next >=3D '0' && next <=3D '7') {

Wow, good catch.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
