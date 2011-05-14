From: Dan Carpenter <error27@gmail.com>
Subject: Re: Flow graph - identify loop body
Date: Fri, 13 May 2011 19:43:58 -1200
Message-ID: <BANLkTin+brzQZcEoxV6EGmoyS9R6w-cuxw@mail.gmail.com>
References: <BANLkTikjg-6QD3_7H533fUKQm39aAj-xyA@mail.gmail.com>
	<BANLkTimmJJYcmpLE7MevAk-18GxmQpGftw@mail.gmail.com>
	<BANLkTikHXzguWK00TCO41x1_13BffCYyRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44686 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab1ENHn7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 May 2011 03:43:59 -0400
Received: by wwa36 with SMTP id 36so3556609wwa.1
        for <linux-sparse@vger.kernel.org>; Sat, 14 May 2011 00:43:58 -0700 (PDT)
In-Reply-To: <BANLkTikHXzguWK00TCO41x1_13BffCYyRg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Diego Pinheiro <diegoquintanap@gmail.com>
Cc: linux-sparse@vger.kernel.org

On 5/13/11, Diego Pinheiro <diegoquintanap@gmail.com> wrote:
> Hello,
>
> I'm trying to identify loop bodies to write its information in a xml
> file, but i didn't get how sparse works with it.
>
> How could I know which node is a loop body in the flow graph?

You might want try downloading smatch (http://smatch.sf.net) and
looking in smatch_flow.c

regards,
dan carpenter
