Return-Path: <SRS0=3N5e=EG=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD3C388F9
	for <linux-sparse@archiver.kernel.org>; Sat, 31 Oct 2020 20:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C18920723
	for <linux-sparse@archiver.kernel.org>; Sat, 31 Oct 2020 20:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="g6P1Vg2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgJaUuk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 31 Oct 2020 16:50:40 -0400
Received: from avasout01.plus.net ([84.93.230.227]:59671 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgJaUuk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 31 Oct 2020 16:50:40 -0400
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id Yxpek1T3Un8O7YxpfkHnaE; Sat, 31 Oct 2020 20:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604177439; bh=WGgjDRLMH2xwEN152itzlQSIlZrENIKMzYl17WCHT94=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=g6P1Vg2MFIlxBqUrhqQOGc5v7FNSiCa/WdHgGEdExrh6DvNd/vCbU5oxEVDo9Qv2p
         cJFqDJsF/o+Z30bWoAjIe+K4UDuMECnBp1ljArG+aiacqWhq47Qg7GuvNidIwZ6HvO
         Iirwim4H+hExrVR5pksLH8ouuQQ6RHkdqYdfShffGTY2JAOzQp9mSfvF0XMifglOrZ
         FCWK5pCpfQFMIiHPyyuWV0NbdlhhjGhA/u/SA9uPQmXc3mocdpCokDoNyUOm4q69EY
         ZWlskFwyX0zZkO4hKsE058LuiL50kHuTCshjKd4+mNRPA0UvmwCczGZzUsIZEtyIkB
         Qdof5DESIZqeA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=zdUYk-12oHltixdIUwkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] testsuite: add a new tag: check-output-match
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20201031200402.31312-1-luc.vanoostenryck@gmail.com>
 <20201031200402.31312-2-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6cc4c620-0821-d3dc-6d46-803344a379bf@ramsayjones.plus.com>
Date:   Sat, 31 Oct 2020 20:50:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201031200402.31312-2-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGyNqE2j2ZfkqAz9PkFHDdnz5sF6D0aYtcNnoWZ2t3J1Hifz0a+YzptDv4J5ZwSui0M62q8mv0Y1Nl2O1CMCdH0UUutRosecdi3gi7igvpx7gMY60XKV
 70Lgd9qFL3Mk2Gb9hjmVd5n0EpLmWgJ+V04WNXOFwfRzCcMvwkN35kvMbfeT/Lj7Re+FavEgD8CaMQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 31/10/2020 20:04, Luc Van Oostenryck wrote:
> The current tags check-output-contains/excludes/pattern are
> quite powerful, universal, but they often need 'complex' regular
> expressions with escaping which make them not so nice to read.
> 
> For testing IR results, a very common pattern is:
> 	this instruction must have this (kind of) operand.
> 
> So, make a new tag for this. It does nothing than can't be done
> with done with the previous ones, on  the contrary, but is much
> simpler to use:
> 	check-output-match(instruction): operand
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Documentation/test-suite.rst |  8 ++++++++
>  validation/test-suite        | 29 +++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/test-suite.rst b/Documentation/test-suite.rst
> index 333106ee138a..4ff2db2f8777 100644
> --- a/Documentation/test-suite.rst
> +++ b/Documentation/test-suite.rst
> @@ -88,6 +88,14 @@ Tag's syntax
>  	of the number of times the pattern should occur in the output.
>  	If *min* or *max* is ``-`` the corresponding check is ignored.
>  
> +``check-output-match(``\ *start*\ ``):`` *pattern*
> +
> +	Check that in the output (stdout) all lines starting with the
> +	first pattern also contains the second pattern. This should be
> +	reserved for matching IR instructions since the '.$size' suffix
> +	is ignored in the first pattern but is expected to be followed
> +	by a space character.
> +
>  Using test-suite
>  ================
>  
> diff --git a/validation/test-suite b/validation/test-suite
> index f7d992dc7c8c..1f229439d699 100755
> --- a/validation/test-suite
> +++ b/validation/test-suite
> @@ -77,6 +77,7 @@ get_tag_value()
>  	check_output_contains=0
>  	check_output_excludes=0
>  	check_output_pattern=0
> +	check_output_match=0
>  	check_arch_ignore=""
>  	check_arch_only=""
>  	check_assert=""
> @@ -100,6 +101,7 @@ get_tag_value()
>  		check-output-contains:)	check_output_contains=1 ;;
>  		check-output-excludes:)	check_output_excludes=1 ;;
>  		check-output-pattern)	check_output_pattern=1 ;;
> +		check-output-match)	check_output_match=1 ;;
>  		check-arch-ignore:)	arch=$(uname -m)
>  					check_arch_ignore="$val" ;;
>  		check-arch-only:)	arch=$(uname -m)
> @@ -204,6 +206,26 @@ minmax_patterns()
>  	return $?
>  }
>  
> +##
> +match_patterns()
> +{
> +	ifile="$1"
> +	patt="$2"
> +	ofile="$3"
> +	grep "$patt" "$ifile" | sed -e "s/^.*$patt(\(.*\)): *\(.*\)$/\1 \2/" | \
> +	while read ins pat; do
> +		echo "ins: $ins"
> +		echo "pat: $pat"

Left-over debug?

ATB,
Ramsay Jones

> +		grep -s "^	$ins\\.*[0-9]* " "$ofile" | grep -v -s -q "$pat"
> +		if [ "$?" -ne 1 ]; then
> +			error "	IR doesn't match '$pat'"
> +			return 1
> +		fi
> +	done
> +
> +	return $?
> +}
> +
>  ##
>  # arg_file(filename) - checks if filename exists
>  arg_file()
> @@ -395,6 +417,13 @@ do_test()
>  			test_failed=1
>  		fi
>  	fi
> +	if [ $check_output_match -eq 1 ]; then
> +		# verify the 'check-output-match($insn): $patt' tags
> +		match_patterns "$file" 'check-output-match' $file.output.got
> +		if [ "$?" -ne "0" ]; then
> +			test_failed=1
> +		fi
> +	fi
>  
>  	if [ "$must_fail" -eq "1" ]; then
>  		if [ "$test_failed" -eq "1" ]; then
> 
