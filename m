From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH] refactor handle_switch_f
Date: Thu, 8 Jan 2009 20:25:39 -0800
Message-ID: <70318cbf0901082025h1c0f97absf62c049f725df2ed@mail.gmail.com>
References: <70318cbf0901081213i22dc8054yda4230e8a6375e9a@mail.gmail.com>
	 <20090108204937.6511.56533.stgit@vmbox.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:37381 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbZAIEZk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Jan 2009 23:25:40 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8741894rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jan 2009 20:25:40 -0800 (PST)
In-Reply-To: <20090108204937.6511.56533.stgit@vmbox.hanneseder.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>, Junio C Hamano <junio@pobox.com>

On Thu, Jan 8, 2009 at 12:50 PM, Hannes Eder <hannes@hanneseder.net> wrote:
> This also fixes a possible source of bugs in parsing other
> -f<whatever> options, i.e. -ftabstop=foo would set the option -ffoo.
>
> Signed-off-by: Hannes Eder <hannes@hanneseder.net>

Applied.

Chris
