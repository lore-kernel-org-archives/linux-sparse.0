From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH v2] Add -ftabstop=WIDTH
Date: Sat, 3 Jan 2009 15:19:31 -0800
Message-ID: <70318cbf0901031519w15929f58p68ff62ace683a5b0@mail.gmail.com>
References: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
	 <70318cbf0812311226gc18b63dld37072c3b7f41719@mail.gmail.com>
	 <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
	 <7v7i5c7g5b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:21610 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760060AbZACXTd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 3 Jan 2009 18:19:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6339500rvb.1
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jan 2009 15:19:31 -0800 (PST)
In-Reply-To: <7v7i5c7g5b.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>

On Sat, Jan 3, 2009 at 4:01 AM, Junio C Hamano <junio@pobox.com> wrote:
> "Hannes Eder" <hannes@hanneseder.net> writes:
>
>> diff --git a/lib.c b/lib.c
>> index 059ba3b..221e7b8 100644
>> --- a/lib.c
>> +++ b/lib.c
>> @@ -15,6 +15,8 @@
>>  #include <string.h>
>>  #include <unistd.h>
>>  #include <assert.h>
>> +#include <limits.h>
>> +#include <errno.h>
>
> These includes after Chris's simplification should not be needed, no?

Good catch. I incorporate it as well.

While you are here. I have a question regarding how to publish patch series
with git.

Take this patch as example. I want to have some repository to allow
others to pull the early version of the patch for testing. I also want
to incorporate
changes into the patch itself.

If I am using patch series. That is easy, just republish a new series.

With git, I can:
1) always submit incremental changes to master branch. Then the patch will
    be fragmented. I want the clean up version of the history.
2) Use rebase or cherry-pick to update the master branch. That will change
    the history of the commit. it causes trouble for people who pull the earlier
   version of the patch.
3) Always use a new branch to publish a new patch series. Then people who
   pull it need to know which branch to pull. It seems that I want an alias for
   the branch. On the client side it can use the same alias to pull different
   branch. I haven't figure out how to do that with git yet.

Any suggestions?

Thanks

Chris
