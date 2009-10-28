From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fix incorrect linearization of "x && y && z"
Date: Wed, 28 Oct 2009 15:48:43 -0700
Message-ID: <70318cbf0910281548j23167f7anf968b29b9ef34067@mail.gmail.com>
References: <4ae782bd.8602be0a.3a31.187a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:61407 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbZJ1Wsi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Oct 2009 18:48:38 -0400
Received: by iwn10 with SMTP id 10so964785iwn.4
        for <linux-sparse@vger.kernel.org>; Wed, 28 Oct 2009 15:48:43 -0700 (PDT)
In-Reply-To: <4ae782bd.8602be0a.3a31.187a@mx.google.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Daniel De Graaf <danieldegraaf@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Oct 27, 2009 at 4:02 PM, Daniel De Graaf
<danieldegraaf@gmail.com> wrote:
> This fixes an incorrect assumption that results in && using shortcut
> logic on the true branch instead of the false branch.

Good catch. Thanks!
I applied it without the "else" line.

Chris

PS. I almost miss this email because it is send to "unlisted-recipients".
My patch tool catches it though.
