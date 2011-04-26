From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] use ARRAY_SIZE() when possible (continued)
Date: Tue, 26 Apr 2011 00:32:21 -0700
Message-ID: <BANLkTinvqZZK5GdKqWQUmE3X15wU2Ju+uQ@mail.gmail.com>
References: <4DA5B222.2080501@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46175 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500Ab1DZHct convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Apr 2011 03:32:49 -0400
Received: by wwa36 with SMTP id 36so372157wwa.1
        for <linux-sparse@vger.kernel.org>; Tue, 26 Apr 2011 00:32:48 -0700 (PDT)
In-Reply-To: <4DA5B222.2080501@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: linux-sparse@vger.kernel.org

On Wed, Apr 13, 2011 at 7:24 AM, Jan Pokorn=FD <pokorny_jan@seznam.cz> =
wrote:
> Some cases were omitted with the patch from Namhyung Kim
> (commit c5e425e in Chris Li's repo).
>
> My curiosity led me to try out coccinelle/spatch as suggested by
> Nicholas Mc Guire in reply to Kim's patch, but it*) only discovered
> occurrences in show-parse.c, probably because of "const vs. non-const=
"
> differences of array item types and the expression given to sizeof.

Applied.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
