From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH v2] Add -ftabstop=WIDTH
Date: Sat, 3 Jan 2009 14:41:55 -0800
Message-ID: <70318cbf0901031441y790f448y2612b272369a5df0@mail.gmail.com>
References: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
	 <70318cbf0812311226gc18b63dld37072c3b7f41719@mail.gmail.com>
	 <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:19527 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbZACWl6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 3 Jan 2009 17:41:58 -0500
Received: by wf-out-1314.google.com with SMTP id 27so6998366wfd.4
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jan 2009 14:41:55 -0800 (PST)
In-Reply-To: <154e089b0901020622u26848778q56d9510e6edc60ff@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>, Junio C Hamano <junio@pobox.com>

On Fri, Jan 2, 2009 at 6:22 AM, Hannes Eder <hannes@hanneseder.net> wrote:
> I like the part in tokenizer.c, I even simplified it a bit further, to
> use a ternary op, and
> do not use a variable.

I applied your patch with change suggested by Junio C Hamano.

Chris
