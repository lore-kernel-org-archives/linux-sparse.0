From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2] Add -ftabstop=WIDTH
Date: Sat, 03 Jan 2009 04:01:04 -0800
Message-ID: <7v7i5c7g5b.fsf@gitster.siamese.dyndns.org>
References: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
 <70318cbf0812311226gc18b63dld37072c3b7f41719@mail.gmail.com>
 <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbZACMBQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 3 Jan 2009 07:01:16 -0500
In-Reply-To: <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
 (Hannes Eder's message of "Fri, 2 Jan 2009 15:22:28 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>

"Hannes Eder" <hannes@hanneseder.net> writes:

> diff --git a/lib.c b/lib.c
> index 059ba3b..221e7b8 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -15,6 +15,8 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <assert.h>
> +#include <limits.h>
> +#include <errno.h>

These includes after Chris's simplification should not be needed, no?
