From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: add built-in atomic memory access identifiers
Date: Sat, 21 Dec 2013 09:22:55 -0800
Message-ID: <CANeU7QkkFaPrqZi0OW1-Myxm1ObdAHA4xLfCR2bS90PM_Y5VKw@mail.gmail.com>
References: <e016529d-1344-4eaa-8419-86cdf1e830cb@linaro.org>
	<20131210125236.b44159c60acfd62b30b9bc69@linaro.org>
	<CAKb83kaz+csV4Q=0P5Q+L75_CxYnL=RrDh4mSTujPmzJ9B7K-g@mail.gmail.com>
	<e444e44d-ffb4-4ba0-86fd-9b66bc1b08d5@linaro.org>
	<CADz3at2h9gDJkEz9FctvvPqj7_isoXj_hpPzJiQzSi2UNyn97g@mail.gmail.com>
	<CAKb83kYKo=YP4JC2cjo-Y76xEvC45CM=5Wf9rO1Hv-06OSt5-Q@mail.gmail.com>
	<CADz3at1A3id81XpKFf3gJhutWEpFi4zM0+xF=cfY-h_+ABd=gw@mail.gmail.com>
	<20131211120204.4e17a616138823d09c89d298@linaro.org>
	<CAKb83kZ4jYeiFAxpxqVwLtWYA3sobrN0vGDRzK0vs_jommsCwQ@mail.gmail.com>
	<CADz3at0E7W=V17mO6D6hZrLp82VoC42_Jz==iSVUykz6+76phQ@mail.gmail.com>
	<e92f5ecc-097b-401b-8554-6d3ada6be667@linaro.org>
	<20131211150013.e009efdb3fa2321f113a8a8d@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:56204 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab3LURW4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 21 Dec 2013 12:22:56 -0500
Received: by mail-oa0-f43.google.com with SMTP id i7so4215165oag.16
        for <linux-sparse@vger.kernel.org>; Sat, 21 Dec 2013 09:22:55 -0800 (PST)
In-Reply-To: <20131211150013.e009efdb3fa2321f113a8a8d@linaro.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kim Phillips <kim.phillips@linaro.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, lng-odp@linaro.org, bill.fischofer@linaro.org, petri.savolainen@linaro.org, mike.holmes@linaro.org

On Wed, Dec 11, 2013 at 1:00 PM, Kim Phillips <kim.phillips@linaro.org> wrote:
> this patch stops sparse from complaining about them not being
> defined:
>
> source/odp_spinlock.c:41:10: error: undefined identifier '__sync_lock_release'
> source/odp_spinlock.c:54:10: error: undefined identifier '__sync_lock_release'
> ./odp_atomic.h:112:16: error: undefined identifier '__sync_fetch_and_add'
>
> Reported-by: Mike Holmes <mike.holmes@linaro.org>
> Signed-off-by: Kim Phillips <kim.phillips@linaro.org>


Applied and pushed.

Chris
