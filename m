From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Reduced call graph
Date: Wed, 16 Nov 2011 20:23:57 +0700
Message-ID: <CACsJy8A2X0WukKXerJAN6pxARoGSh1O=8FM+iTZL-xzDCQ1W=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59900 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab1KPNY3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Nov 2011 08:24:29 -0500
Received: by bke11 with SMTP id 11so532921bke.19
        for <linux-sparse@vger.kernel.org>; Wed, 16 Nov 2011 05:24:27 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

Is it possible to ask "graph" to generate a call graph of all calls
from main() to specific function? If "graph" does not support it (I
suspect so after looking at graph.c), could you please give me a few
hints how to do it? I'm completely new to sparse.
-- 
Duy
