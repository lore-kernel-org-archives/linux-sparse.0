Return-Path: <SRS0=3N5e=EG=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17703C388F7
	for <linux-sparse@archiver.kernel.org>; Sat, 31 Oct 2020 20:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC24206F7
	for <linux-sparse@archiver.kernel.org>; Sat, 31 Oct 2020 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hixqk4MN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgJaUEJ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 31 Oct 2020 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgJaUEJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 31 Oct 2020 16:04:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F96C0617A6
        for <linux-sparse@vger.kernel.org>; Sat, 31 Oct 2020 13:04:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id dg9so10132537edb.12
        for <linux-sparse@vger.kernel.org>; Sat, 31 Oct 2020 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vj1rfLfOgC8ZOM+rm36p82r5mgL3NJMjdz1FYwF5fTc=;
        b=hixqk4MN3G7nUfVaCPtih5/1aiwzScobOApXo3zgzUWB97RGRXVsAIQW7whwxbv3vN
         A73xS5Eukrvq7ZFgaNt7eOaCJT2EABawCOwQbpKE9uBiQ+wtxJBT+aHOpALAn4LpE7nq
         Y/uTsrvRmKrJs8Uh155kLNUFkzqRW3kOFSjmifQ4vOUTnwYgXruDyFCqi+U4PjgoF2IK
         ymbjNGATG/TuEEBw5vrpgxQwDFA4EHgIClQOhmun9DaTxo4e8RsvJsyngRgtugzS0y2c
         dLE+u2jhlSo9ZDzQGTpJx/BPlKvisODPhQ5jEjyo9DL+BAmFuIR/XR4lYvU8CSjZIKjD
         QFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vj1rfLfOgC8ZOM+rm36p82r5mgL3NJMjdz1FYwF5fTc=;
        b=B7Xjs96DDuToLzr8nzVrJTOyen1JfrYg6Vi5cHFvN1VEIhEpxPUlNztu2rsI82Ld9Y
         5/k4MimGKgeaIsLh0naCdhemTmUoLzhGBSoPapb98dYpuSK2rXY4glYOAyT59x4QRWEV
         KwDb+4Ur4AaSv1YiBJyxwgxL2LLXrKjJpWXP2a9xXrhYzIQ3TMRbYeBQWnP7F+IUuiPo
         cH/vvJwEcUF1dXxA+6RksBdFmOGOLY0doVoJfiYXEVZtifgZYIO0s8gImvseP/XU4rdz
         JlFKdPW8En6k59r7TFnYrZWn6YjMjj9dfw0tuXKcD6VnLR+mM73GNQgEeMeUrBzbho1u
         1B1w==
X-Gm-Message-State: AOAM533sdS9RSsMNBWOO715/fJWvNnr9nzvTDBU2i5N4X4NgMAR+C5TF
        ecRlPF+afLPQzDWsLqSsSTDlQvql+9k=
X-Google-Smtp-Source: ABdhPJyNvwEYO1cxa1Rj+RTXIBePbo34ZkYZ5Tsfm+qX4YnROUAmwey6ecyS6ifMv2NAGAvj+Xnvwg==
X-Received: by 2002:aa7:c984:: with SMTP id c4mr8925122edt.42.1604174647358;
        Sat, 31 Oct 2020 13:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a86e:27a8:de95:3d6])
        by smtp.gmail.com with ESMTPSA id u26sm6070667edt.39.2020.10.31.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:04:06 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] testsuite: add a new tag: check-output-match
Date:   Sat, 31 Oct 2020 21:04:01 +0100
Message-Id: <20201031200402.31312-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201031200402.31312-1-luc.vanoostenryck@gmail.com>
References: <20201031200402.31312-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current tags check-output-contains/excludes/pattern are
quite powerful, universal, but they often need 'complex' regular
expressions with escaping which make them not so nice to read.

For testing IR results, a very common pattern is:
	this instruction must have this (kind of) operand.

So, make a new tag for this. It does nothing than can't be done
with done with the previous ones, on  the contrary, but is much
simpler to use:
	check-output-match(instruction): operand

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite.rst |  8 ++++++++
 validation/test-suite        | 29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/test-suite.rst b/Documentation/test-suite.rst
index 333106ee138a..4ff2db2f8777 100644
--- a/Documentation/test-suite.rst
+++ b/Documentation/test-suite.rst
@@ -88,6 +88,14 @@ Tag's syntax
 	of the number of times the pattern should occur in the output.
 	If *min* or *max* is ``-`` the corresponding check is ignored.
 
+``check-output-match(``\ *start*\ ``):`` *pattern*
+
+	Check that in the output (stdout) all lines starting with the
+	first pattern also contains the second pattern. This should be
+	reserved for matching IR instructions since the '.$size' suffix
+	is ignored in the first pattern but is expected to be followed
+	by a space character.
+
 Using test-suite
 ================
 
diff --git a/validation/test-suite b/validation/test-suite
index f7d992dc7c8c..1f229439d699 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -77,6 +77,7 @@ get_tag_value()
 	check_output_contains=0
 	check_output_excludes=0
 	check_output_pattern=0
+	check_output_match=0
 	check_arch_ignore=""
 	check_arch_only=""
 	check_assert=""
@@ -100,6 +101,7 @@ get_tag_value()
 		check-output-contains:)	check_output_contains=1 ;;
 		check-output-excludes:)	check_output_excludes=1 ;;
 		check-output-pattern)	check_output_pattern=1 ;;
+		check-output-match)	check_output_match=1 ;;
 		check-arch-ignore:)	arch=$(uname -m)
 					check_arch_ignore="$val" ;;
 		check-arch-only:)	arch=$(uname -m)
@@ -204,6 +206,26 @@ minmax_patterns()
 	return $?
 }
 
+##
+match_patterns()
+{
+	ifile="$1"
+	patt="$2"
+	ofile="$3"
+	grep "$patt" "$ifile" | sed -e "s/^.*$patt(\(.*\)): *\(.*\)$/\1 \2/" | \
+	while read ins pat; do
+		echo "ins: $ins"
+		echo "pat: $pat"
+		grep -s "^	$ins\\.*[0-9]* " "$ofile" | grep -v -s -q "$pat"
+		if [ "$?" -ne 1 ]; then
+			error "	IR doesn't match '$pat'"
+			return 1
+		fi
+	done
+
+	return $?
+}
+
 ##
 # arg_file(filename) - checks if filename exists
 arg_file()
@@ -395,6 +417,13 @@ do_test()
 			test_failed=1
 		fi
 	fi
+	if [ $check_output_match -eq 1 ]; then
+		# verify the 'check-output-match($insn): $patt' tags
+		match_patterns "$file" 'check-output-match' $file.output.got
+		if [ "$?" -ne "0" ]; then
+			test_failed=1
+		fi
+	fi
 
 	if [ "$must_fail" -eq "1" ]; then
 		if [ "$test_failed" -eq "1" ]; then
-- 
2.29.2

