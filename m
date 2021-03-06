Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2DAC433DB
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E3C65017
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFQZ2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 11:25:28 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40601 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhCFQYv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 11:24:51 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id IZjUlZW7mg7CTIZjVlzKWq; Sat, 06 Mar 2021 16:24:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1615047890; bh=jCqCxYHTvPF8Y9rBguqmYRJM4BC+P8OyziVHMYUT5yY=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=rOkOu7uZd+8ijE3lj0D3Fe3OuyhY/G9Huo169C9gYfjndWHenKP/imOrUcLDeE9kn
         V/hy0qWrhKh3C56aIJ1Ij3Y+BvxI4HTrOV1ii6WivPnlsLATb27kNraWkx+t263Hmr
         AIWoFj6Qsb0cNHB2H8zWLby3mzrHfwrst3doYzFkgyCFpQCro3QI7NWJkuVCS+7OuL
         TZ08rtcD2NcbBw53TpTKXDU5V3V7k3SRnzNHc9p2uH6VXkMove/HIOx/X26iQPSxEr
         2MQlKCYzoa5an2vR0vS4I7Ms4d6tJrgRHuYL+KadtPdKFc5D5ndNdbDXFlZEhgV4Is
         Zjw7D4He0ULyA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cYFJUkLM c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=D1EP05X3OIxpf7RXn7QA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/6] ptrlist: use ptr_list_nth() instead of
 linearize_ptr_list()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
 <20210306100552.33784-5-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <346a9e29-1403-9496-b372-932f5a2b2c88@ramsayjones.plus.com>
Date:   Sat, 6 Mar 2021 16:24:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306100552.33784-5-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL09U+eJR7vuy5wR4JegyNggHDcR7fnwtv2o8+1wQs6v2kVhdCYAWnqQ1AbpOAvXkJrwi6U+tV4KOocWzj+WtqQXnheZTX74VUsTbRiPx/auGa/OEOBx
 BkKO8VyGWXWNXtUeixRzTF86sHH47zvFkikOWaN06YP6SaLHvSrHKnd6hrFveIpCeL8W1yVfKHC8bw==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/03/2021 10:05, Luc Van Oostenryck wrote:
> Sparse has a few extra checkers for some functions.
> The one for memset has its own helper the retrieve its 3rd arguments.

s/the retrieve its 3rd arguments/to retrieve its 3rd argument/

ATB,
Ramsay Jones

> 
> Remove this helper and use the generic ptr_list_nth() instead.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  sparse.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/sparse.c b/sparse.c
> index 151eaf4ef5ed..9d62d4fe4fc4 100644
> --- a/sparse.c
> +++ b/sparse.c
> @@ -163,20 +163,9 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
>  	/* OK, we could try to do the range analysis here */
>  }
>  
> -static pseudo_t argument(struct instruction *call, unsigned int argno)
> -{
> -	pseudo_t args[8];
> -	struct ptr_list *arg_list = (struct ptr_list *) call->arguments;
> -
> -	argno--;
> -	if (linearize_ptr_list(arg_list, (void *)args, 8) > argno)
> -		return args[argno];
> -	return NULL;
> -}
> -
>  static void check_memset(struct instruction *insn)
>  {
> -	check_byte_count(insn, argument(insn, 3));
> +	check_byte_count(insn, ptr_list_nth(insn->arguments, 3));
>  }
>  
>  #define check_memcpy check_memset
> 
