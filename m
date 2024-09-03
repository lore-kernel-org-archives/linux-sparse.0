Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B818452D
	for <linux-sparse@vger.kernel.org>; Tue,  3 Sep 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344024; cv=none; b=FsJQVoP1B3GXUUBD0T56YuC6+YDL0U0Lhd5biiEBdP71Me0yYOZqcMXrjW8q9sern2DmzCfJu33BUXU9FoM2Ps7eSPxrYYvEy6MJuc6RtHGXDwXnNOLYwVtwADL66zUoCkDKtV72SurWoUW4o33AvtC50r5Ts4hinEnV3z/owIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344024; c=relaxed/simple;
	bh=vg0mnb+xpP2nzfOjHEOu7/eYP0B1JIrquPfgYKcE3VA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CEgqbMbURN8YBzSUaoN90ES3LyPPCU7UZCpivCGfAAP26Dmq7AWGS7P+SmI3lmnWY95Zu0ryXyqezNCTB8PVlk2W7WX7mxan8vV3my2Lv6pZqerBnYHKcOVnnHh+8Gf4RxtUNOogCOxCMvpe4gtrxCCnHyDl0Rsy8nCDnibkAKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+NL074Q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+NL074Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725344023; x=1756880023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vg0mnb+xpP2nzfOjHEOu7/eYP0B1JIrquPfgYKcE3VA=;
  b=V+NL074Q50LAVPVgWjPESeVuxLTV9TQYJ99v4bg02CSYmfncGB7LwNii
   jQyRhZdj62A+ay95PBkDqgDU+9HGe7/xGumygtu3Y40y+qVl3HP4VTKeN
   0NN6AJg3Npcu9HKKctPcbXov2bpsKgkLIn4deU+w2basBVniNq7+RuZB4
   MtcJvwhtD6GgaiaOjiUIcvT1Zf4Z3CpXDopCCFNbaXH0HF6ZSnJOL6fVi
   s0ePa7Nj4S/wSo0m4tb2ZIt728+I0hRRbOj8kZlFEttAMH4SuC5OuJZOk
   ba6Xy4nHUGI95UkfLeVBygucabE6qcFwj6UfE3atiuWXOPuU+j4W23Pyu
   Q==;
X-CSE-ConnectionGUID: N/ImUdbGRc2SCMASY2/k0Q==
X-CSE-MsgGUID: cwLwOnjBTXSDPzUox+k7lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="26833563"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="26833563"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:13:42 -0700
X-CSE-ConnectionGUID: TsRYs+ZGThy2eSxjefBXsQ==
X-CSE-MsgGUID: Qx0vHrVlTwKP7Jk6bO7okw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="64798006"
Received: from rgavrus-mobl1.ger.corp.intel.com (HELO soc-CND1340XR6.clients.intel.com) ([10.245.120.243])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2024 23:13:41 -0700
From: Dmitrii Golovanov <dmitrii.golovanov@intel.com>
To: linux-sparse@vger.kernel.org
Cc: Dmitrii Golovanov <dmitrii.golovanov@intel.com>
Subject: [PATCH] cgcc: check sparse options fmax-errors and fmax-warnings
Date: Tue,  3 Sep 2024 08:12:57 +0200
Message-Id: <20240903061257.648402-1-dmitrii.golovanov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Recognize sparse command-line options `-fmax-errors` and `-fmax-warnings`
as "check" options:

  `-fmax-warnings` - dont pass it to CC neither with integer value,
    nor as 'unlimited'.
  `-fmax-errors` - only as 'unlimited' value to avoid 'unrecognized
    command-line option' GCC error which also accepts it as numeric.

Signed-off-by: Dmitrii Golovanov <dmitrii.golovanov@intel.com>
---
 cgcc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cgcc b/cgcc
index 618ba08a..b90e9428 100755
--- a/cgcc
+++ b/cgcc
@@ -129,6 +129,8 @@ sub check_only_option {
     return 1 if $arg =~ /^-W(no-?)?(address-space|bitwise|cast-to-as|cast-truncate|constant-suffix|context|decl|default-bitfield-sign|designated-init|do-while|enum-mismatch|external-function-has-definition|init-cstring|memcpy-max-count|non-pointer-null|old-initializer|one-bit-signed-bitfield|override-init-all|paren-string|ptr-subtraction-blows|return-void|sizeof-bool|sparse-all|sparse-error|transparent-union|typesign|undef|unknown-attribute)$/;
     return 1 if $arg =~ /^-v(no-?)?(entry|dead)$/;
     return 1 if $arg =~ /^-f(dump-ir|memcpy-max-count|diagnostic-prefix)(=\S*)?$/;
+    return 1 if $arg =~ /^-fmax-errors=unlimited$/;  # don't pass it to GCC
+    return 1 if $arg =~ /^-fmax-warnings=(unlimited|[0-9]+)$/;
     return 1 if $arg =~ /^-f(mem2reg|optim)(-enable|-disable|=last)?$/;
     return 1 if $arg =~ /^-msize-(long|llp64)$/;
     return 0;
-- 
2.25.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

