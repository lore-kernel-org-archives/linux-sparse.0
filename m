From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse: Add 'leaf' to ignored attributes.
Date: Wed, 18 Jan 2012 09:20:58 +0200
Message-ID: <CAOJsxLGNfSBZ9evmBaV6gN0rYorOUF85JJ9FNKXni01cvD1pVw@mail.gmail.com>
References: <1326840431-27368-1-git-send-email-ethan@nicira.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:52807 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755302Ab2ARHU6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jan 2012 02:20:58 -0500
Received: by obcva7 with SMTP id va7so6821129obc.19
        for <linux-sparse@vger.kernel.org>; Tue, 17 Jan 2012 23:20:58 -0800 (PST)
In-Reply-To: <1326840431-27368-1-git-send-email-ethan@nicira.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ethan Jackson <ethan@nicira.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Wed, Jan 18, 2012 at 12:47 AM, Ethan Jackson <ethan@nicira.com> wrot=
e:
> This patch adds the 'leaf' GCC attribute to the list of ignored
> attributes. =A0Glibc uses this attribute causing the following
> warnings in userspace projects:
>
> =A0/usr/include/stdlib.h:514:26: error: attribute '__leaf__': unknown=
 attribute
>
> Signed-off-by: Ethan Jackson <ethan@nicira.com>

Acked-by: Pekka Enberg <penberg@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
