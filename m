From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH] Add -ftabstop=WIDTH
Date: Wed, 31 Dec 2008 18:29:49 +0300
Message-ID: <f19298770812310729k6dbe23b2vba2a79f0c86597c@mail.gmail.com>
References: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:57897 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbYLaP3w (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Dec 2008 10:29:52 -0500
Received: by bwz14 with SMTP id 14so18552924bwz.13
        for <linux-sparse@vger.kernel.org>; Wed, 31 Dec 2008 07:29:49 -0800 (PST)
In-Reply-To: <20081231124108.10969.28189.stgit@vmbox.hanneseder.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: linux-sparse@vger.kernel.org

On Wed, Dec 31, 2008 at 15:41, Hannes Eder <hannes@hanneseder.net> wrote:
> Make tokenizer aware of tabstops and add the commandline option:
>
> -ftabstop=WIDTH
>    Set the distance between tab stops.  This helps sparse report correct
>    column numbers in warnings or errors.  If the value is less than 1 or
>    greater than 100, the option is ignored.  The default is 8.

Handling tabs is probably a good idea, but making tabstop an option looks
a bit like overkill. Maybe just hardcode it as 8?
