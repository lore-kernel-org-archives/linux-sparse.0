From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] recognize binary constants
Date: Tue, 15 Nov 2011 22:35:35 +0300
Message-ID: <CA+_b7D+qrLK4EfDjf+gPM+291Khhz6EuJakT=N4N1R3HSHq+Nw@mail.gmail.com>
References: <1315434714.1892.7.camel@marconi>
	<20110908170734.GB17041@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64166 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757212Ab1KOTff (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Nov 2011 14:35:35 -0500
In-Reply-To: <20110908170734.GB17041@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Kamal Mostafa <kamal@canonical.com>, smatch@vger.kernel.org

On 9/8/11, Dan Carpenter <error27@gmail.com> wrote:
> Sparse doesn't parse binary constants properly so the following code
> generates an error:
>
> 	x = 0b11;
>
> test.c:5:17: error: constant 0b11 is not a valid number
>
> Reported-by: Kamal Mostafa <kamal@canonical.com>
> Signed-off-by: Dan Carpenter <error27@gmail.com>

I sent this patch before but the git tree was offline so everything
was dead.

regards,
dan carpenter
