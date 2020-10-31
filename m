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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5741C55179
	for <linux-sparse@archiver.kernel.org>; Sat, 31 Oct 2020 20:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E229206F9
	for <linux-sparse@archiver.kernel.org>; Sat, 31 Oct 2020 20:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiQmoWBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgJaUEK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 31 Oct 2020 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgJaUEK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 31 Oct 2020 16:04:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B6FC0617A6
        for <linux-sparse@vger.kernel.org>; Sat, 31 Oct 2020 13:04:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id za3so13223419ejb.5
        for <linux-sparse@vger.kernel.org>; Sat, 31 Oct 2020 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u7ayPkxsVQOEJsJcIrPhc/IzWODg0k7zyTutNBftqPE=;
        b=CiQmoWBOzh/2arqb5rED2QsoXN85qKCvcj5GIRRXm/JRJoDJO7stVGXkpxEqupkRM1
         U4wWNt/mGwaBv1LUzSgTRQvFyT7vNYvD49hyXwMFnZytUTaZmQNRw+efWZIRCuT8c4Pd
         PyMrUxcOWCGieLI9gppqG1Ti4xuN+0voX+8VAx9uV/9hHkl7e805jg7FuzTrg7XaHZMg
         rPyfnOsiCtGmfvH39mKyyyZ1X5oJswUu8DTuMDEMSYtWjaJwft9MFi7DxLHpz/tu2szb
         BwoXzBLygNh3RwKLEhxvlEUcWKuqJ3EpIM6B6WcBMyZTOh6xH/c5fqL0m50y6KgoSZUR
         NrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7ayPkxsVQOEJsJcIrPhc/IzWODg0k7zyTutNBftqPE=;
        b=B29HpWQecbImk1K8KgYAAPRp/gVoxsh+erLeC6FW/HZzOwAIX9/EujMlzF0RdYh+72
         KdAB5+aU5gCKgo9kuC5SrZ3/a0Ara3yC+67weLp5lxTOkW7Vr8Jgu/7KSuB+glCJURDA
         bmWFRuqF36OBjiZLH+8l5fp7NcCfIjg7FVMV4BTq0py/d7D17A9h5KDVcTQytJSxVbgX
         yTNX7qsaYG52F5I2kVb+Xm6zepMVa3P42cc2BCBHWTeng75vCZzbZZHCl7y/oVf/TT5r
         bwmxdQcbFOVAC+DnFA+AOEpwEk7j6EC/yPsh4qjOKEkbhdfB8V5H7TBtK3PnqDLN7CKi
         C6ZA==
X-Gm-Message-State: AOAM531M6im78ZOmNahLZVORsG6hXeCq0eZJfaQeo3TsX36mchC5nfwC
        xZT0dkgnTse7exmZznJoYiWUG5cNEUI=
X-Google-Smtp-Source: ABdhPJxG8u+cbjJQ67JgV31u2hguM4lPFt6ticJgyvRq4gd4udd17Nr5+j0HK7h6ZFST2UG5+EoxDw==
X-Received: by 2002:a17:906:329b:: with SMTP id 27mr8103872ejw.329.1604174648335;
        Sat, 31 Oct 2020 13:04:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a86e:27a8:de95:3d6])
        by smtp.gmail.com with ESMTPSA id u26sm6070667edt.39.2020.10.31.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:04:07 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] testsuite: add a new tag: check-output-returns
Date:   Sat, 31 Oct 2020 21:04:02 +0100
Message-Id: <20201031200402.31312-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201031200402.31312-1-luc.vanoostenryck@gmail.com>
References: <20201031200402.31312-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current tags check-output-contains/excludes/pattern are
quite powerful and the new check-output-match is easy to use
but it can be even simpler. Indeed, a lot of IR simplifications/
canonicalizations can be tested by checking that the expression
to be tested is equivalent to another one. This is less precise
than some more specific tests but:
* it's a big advantage because it's less sensitive to 'noise'
  like the exact number used by the pseudos or to the results
  of some new simplifications or canonicalizations
* very often, this equivalence is what really matters and not
  the exact transformation.

So, add a new utra-simple-to-use tag: just ask that all functions
of the tests return the same specified value (usually 1):
	check-output-returns: <value>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite.rst |  5 +++++
 validation/test-suite        | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/test-suite.rst b/Documentation/test-suite.rst
index 4ff2db2f8777..3181e109a104 100644
--- a/Documentation/test-suite.rst
+++ b/Documentation/test-suite.rst
@@ -96,6 +96,11 @@ Tag's syntax
 	is ignored in the first pattern but is expected to be followed
 	by a space character.
 
+``check-output-returns:`` *value*
+
+	Check that in the output (stdout) all IR return instructions
+	have the given value.
+
 Using test-suite
 ================
 
diff --git a/validation/test-suite b/validation/test-suite
index 1f229439d699..2307e4e80d75 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -78,6 +78,7 @@ get_tag_value()
 	check_output_excludes=0
 	check_output_pattern=0
 	check_output_match=0
+	check_output_returns=0
 	check_arch_ignore=""
 	check_arch_only=""
 	check_assert=""
@@ -102,6 +103,7 @@ get_tag_value()
 		check-output-excludes:)	check_output_excludes=1 ;;
 		check-output-pattern)	check_output_pattern=1 ;;
 		check-output-match)	check_output_match=1 ;;
+		check-output-returns:)	check_output_returns=1 ;;
 		check-arch-ignore:)	arch=$(uname -m)
 					check_arch_ignore="$val" ;;
 		check-arch-only:)	arch=$(uname -m)
@@ -226,6 +228,24 @@ match_patterns()
 	return $?
 }
 
+##
+return_patterns()
+{
+	ifile="$1"
+	patt="$2"
+	ofile="$3"
+	grep "$patt:" "$ifile" | sed -e "s/^.*$patt: *\(.*\)$/\1/" | \
+	while read ret; do
+		grep -s "^	ret\\.[0-9]" "$ofile" | grep -v -s -q "[ \$]${ret}\$"
+		if [ "$?" -ne 1 ]; then
+			error "	Return doesn't match '$ret'"
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
@@ -424,6 +444,13 @@ do_test()
 			test_failed=1
 		fi
 	fi
+	if [ $check_output_returns -eq 1 ]; then
+		# verify the 'check-output-return: $value' tags
+		return_patterns "$file" 'check-output-returns' $file.output.got
+		if [ "$?" -ne "0" ]; then
+			test_failed=1
+		fi
+	fi
 
 	if [ "$must_fail" -eq "1" ]; then
 		if [ "$test_failed" -eq "1" ]; then
-- 
2.29.2

