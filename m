From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] use ARRAY_SIZE() when possible
Date: Fri, 10 Dec 2010 00:56:00 -0800
Message-ID: <AANLkTi=2AoU3uHgvUtv=RHUurUbuAQexSHBsRs_NC8Cv@mail.gmail.com>
References: <1291894020-3388-1-git-send-email-namhyung@gmail.com>
	<20101209123602.GB5470@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:62973 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab0LJI4B (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Dec 2010 03:56:01 -0500
Received: by iwn40 with SMTP id 40so4948308iwn.3
        for <linux-sparse@vger.kernel.org>; Fri, 10 Dec 2010 00:56:01 -0800 (PST)
In-Reply-To: <20101209123602.GB5470@opentech.at>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Namhyung Kim <namhyung@gmail.com>, linux-sparse@vger.kernel.org

On Thu, Dec 9, 2010 at 4:36 AM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
> On Thu, 09 Dec 2010, Namhyung Kim wrote:
>
>> Convert (sizeof arr / sizeof arr[0]) to ARRAY_SIZE(arr).
>>
> would that not be a cadidate for coccinelle/spatch rather than a potentially
> error prone and repetitive manual patch?
> array.cocci from the current 0.4.2 coccinelle distribution below should du
> the job.
> Might make sense to add a coccinelle directory in sparse to handle such cases ?
>

Interesting. How do I use the provided script? I assume I need to invoke
coccinelle some how.

Chris
