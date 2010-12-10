From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] use ARRAY_SIZE() when possible
Date: Fri, 10 Dec 2010 00:51:50 -0800
Message-ID: <AANLkTin6mzDoAYNP1RSGxy-7O3w+hg5EZi8JLonGKGMS@mail.gmail.com>
References: <1291894020-3388-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:54200 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab0LJIvv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Dec 2010 03:51:51 -0500
Received: by iwn40 with SMTP id 40so4942738iwn.3
        for <linux-sparse@vger.kernel.org>; Fri, 10 Dec 2010 00:51:50 -0800 (PST)
In-Reply-To: <1291894020-3388-1-git-send-email-namhyung@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Dec 9, 2010 at 3:27 AM, Namhyung Kim <namhyung@gmail.com> wrote:
> Convert (sizeof arr / sizeof arr[0]) to ARRAY_SIZE(arr).
>
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

Looks good.

Chris
