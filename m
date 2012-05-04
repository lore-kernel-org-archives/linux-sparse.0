From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 04 May 2012 23:56:43 +0200
Message-ID: <4FA4509B.5000803@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com> <4FA3B14A.3070609@gaisler.com> <CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com> <4FA44E3D.6020504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50286 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab2EDVxN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 17:53:13 -0400
Received: by lbbgm6 with SMTP id gm6so2352172lbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2012 14:53:11 -0700 (PDT)
In-Reply-To: <4FA44E3D.6020504@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

Append:

> 1. The #if (and #include) nestings (with dependencies
> pointing to the macros used in the proprocessor line)
> 2. The macro expansion trace
> 3. The connection 1+2 into the AST.

Should be:

1. The #if (and #include) nestings (with dependencies
    pointing to the macros used in the proprocessor line)
2. The macro expansion trace (with dependencies
    pointing to the macros used in the expansion)
3. The connection of 1+2 into the AST.

