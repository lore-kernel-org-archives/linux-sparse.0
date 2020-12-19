Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F0C4361B
	for <linux-sparse@archiver.kernel.org>; Sat, 19 Dec 2020 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530BB23AC2
	for <linux-sparse@archiver.kernel.org>; Sat, 19 Dec 2020 11:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgLSL4B (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 19 Dec 2020 06:56:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50134 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgLSL4A (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Dec 2020 06:56:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJBpntQ125791;
        Sat, 19 Dec 2020 11:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fTr59H9+pwafZguYe969aOtTudyLmVtcPaJzJMumBIs=;
 b=Kgu38+EwntFksdoP642iiUuJ4oUisc/h9YrJysu9gQ2kIS0WvAvJkDHvwTAfoqQ50sfD
 RdLG3Gy/5dlVqor1fJ0S6vRGm82TZgfvzyUm1Kkc3OlwkmpJykBVnWTYRVIgX8YFzkY6
 GTykMgXSWLwlNFs20B7hdCOfwIYLmy3QIeAOUHrUdjFhN1LMyV94DPQRTRgFI0ggRXCt
 QfOfROoAu3vVVrgGsUu5cH/2Y35hhB2luX9gjcRGi7zf0Byk02RWyAvwIBY+t/5unBlE
 6Y2misg4e4hxIktgoCkh56XW+jLOj73AziSzKzemKLr3OsTK/6okKvokz5NLXioO/lEe hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35h8xqrrgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Dec 2020 11:55:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJBpO3g047196;
        Sat, 19 Dec 2020 11:55:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35h7j99amb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Dec 2020 11:55:08 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BJBt61M025941;
        Sat, 19 Dec 2020 11:55:06 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Dec 2020 03:55:05 -0800
Date:   Sat, 19 Dec 2020 14:55:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
        edwin.peer@broadcom.com
Subject: Re: sparse annotation for error types?
Message-ID: <20201219115035.GA23630@kadam>
References: <20201205143250.2378b9f9@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <20201208132844.GC2767@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20201208132844.GC2767@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190087
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've pushed my Smatch check for missing error codes.

https://github.com/error27/smatch/commit/be18f90f05b684c12b80b9364b5bbc5dbef922da

I ended up writing a slightly more tricky version of the check because
there were some places that do:

		ret = 0;
		goto out;

And I didn't want to generate a warning for those.  The heuristic is
that if "ret" is up to 3 lines before the goto then it's probably
intentional.  There are still some false positives, especially in fs/
where "ret" is set to zero at the start of the function but it's
inentional.

I considered doing some more checking to say "this is an error path" but
I kind of like it as is.  I have a separate unpublished check for
"this is an error path and there is a goto but the error code is not set"
and I will probably fix that up and publish it as well.  So it will be
two warnings.  :)  Or vs And.

I've also attached the generated warnings from Friday's linux-next if
you want to take a look.

regards,
dan carpenter

--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

sound/usb/caiaq/input.c:807 snd_usb_caiaq_input_init() warn: missing error code 'ret'
sound/soc/tegra/tegra20_ac97.c:349 tegra20_ac97_platform_probe() warn: missing error code 'ret'
fs/xfs/libxfs/xfs_alloc.c:2523 xfs_alloc_fix_freelist() warn: missing error code 'error'
fs/xfs/xfs_reflink.c:660 xfs_reflink_end_cow_extent() warn: missing error code 'error'
fs/adfs/dir_fplus.c:146 adfs_fplus_read() warn: missing error code 'ret'
fs/f2fs/data.c:2200 f2fs_read_multi_pages() warn: missing error code 'ret'
fs/btrfs/ctree.c:517 tree_mod_log_insert_move() warn: missing error code 'ret'
fs/btrfs/ctree.c:748 tree_mod_log_eb_copy() warn: missing error code 'ret'
fs/btrfs/ctree.c:806 tree_mod_log_free_eb() warn: missing error code 'ret'
fs/ubifs/journal.c:886 ubifs_jnl_write_inode() warn: missing error code 'err'
fs/ubifs/journal.c:1564 ubifs_jnl_truncate() warn: missing error code 'err'
fs/gfs2/ops_fstype.c:711 init_journal() warn: missing error code 'error'
fs/gfs2/ops_fstype.c:914 init_per_node() warn: missing error code 'error'
fs/ext4/inode.c:2599 mpage_prepare_extent_to_map() warn: missing error code 'err'
fs/cachefiles/daemon.c:726 cachefiles_has_space() warn: missing error code 'ret'
fs/jfs/jfs_logmgr.c:1327 lmLogInit() warn: missing error code 'rc'
drivers/hid/usbhid/hid-pidff.c:1297 hid_pidff_init() warn: missing error code 'error'
drivers/nvdimm/btt.c:1233 btt_read_pg() warn: missing error code 'ret'
drivers/phy/cadence/phy-cadence-torrent.c:2301 cdns_torrent_phy_probe() warn: missing error code 'ret'
drivers/phy/ti/phy-j721e-wiz.c:892 wiz_probe() warn: missing error code 'ret'
drivers/spi/spi-pic32.c:637 pic32_spi_dma_prep() warn: missing error code 'ret'
drivers/spi/spi-stm32-qspi.c:418 stm32_qspi_send() warn: missing error code 'err'
drivers/staging/media/omap4iss/iss.c:1240 iss_probe() warn: missing error code 'ret'
drivers/pinctrl/pinctrl-single.c:1214 pcs_parse_bits_in_pinctrl_entry() warn: missing error code 'res'
drivers/iommu/ioasid.c:184 ioasid_register_allocator() warn: missing error code 'ret'
drivers/iommu/arm/arm-smmu/qcom_iommu.c:241 qcom_iommu_init_domain() warn: missing error code 'ret'
drivers/iommu/arm/arm-smmu/arm-smmu.c:637 arm_smmu_init_domain_context() warn: missing error code 'ret'
drivers/nfc/nfcmrvl/usb.c:424 nfcmrvl_resume() warn: missing error code 'err'
drivers/dma/idxd/init.c:69 idxd_setup_interrupts() warn: missing error code 'rc'
drivers/dma/idxd/cdev.c:116 idxd_cdev_open() warn: missing error code 'rc'
drivers/usb/early/xhci-dbc.c:965 xdbc_init() warn: missing error code 'ret'
drivers/usb/gadget/legacy/multi.c:403 multi_bind() warn: missing error code 'status'
drivers/usb/gadget/legacy/hid.c:103 do_config() warn: missing error code 'status'
drivers/usb/gadget/legacy/hid.c:175 hid_bind() warn: missing error code 'status'
drivers/usb/gadget/legacy/ether.c:407 eth_bind() warn: missing error code 'status'
drivers/usb/gadget/legacy/g_ffs.c:399 gfs_bind() warn: missing error code 'ret'
drivers/usb/gadget/legacy/mass_storage.c:179 msg_bind() warn: missing error code 'status'
drivers/usb/gadget/legacy/acm_ms.c:204 acm_ms_bind() warn: missing error code 'status'
drivers/usb/usbip/vhci_hcd.c:767 vhci_urb_enqueue() warn: missing error code 'ret'
drivers/input/touchscreen/elo.c:345 elo_connect() warn: missing error code 'err'
drivers/input/touchscreen/sur40.c:790 sur40_probe() warn: missing error code 'error'
drivers/mtd/nand/raw/nand_base.c:842 nand_setup_interface() warn: missing error code 'ret'
drivers/mtd/nand/raw/diskonchip.c:1428 doc_probe() warn: missing error code 'ret'
drivers/mtd/nand/raw/fsmc_nand.c:1085 fsmc_nand_probe() warn: missing error code 'ret'
drivers/misc/habanalabs/gaudi/gaudi.c:7848 gaudi_internal_cb_pool_init() warn: missing error code 'rc'
drivers/misc/habanalabs/common/device.c:1372 hl_device_init() warn: missing error code 'rc'
drivers/gpu/drm/nouveau/nouveau_backlight.c:276 nouveau_backlight_init() warn: missing error code 'ret'
drivers/gpu/drm/gma500/psb_drv.c:317 psb_driver_load() warn: missing error code 'ret'
drivers/gpu/drm/virtio/virtgpu_kms.c:166 virtio_gpu_init() warn: missing error code 'ret'
drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c:478 amdgpu_vmid_alloc_reserved() warn: missing error code 'r'
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:523 init_pmu_entry_by_type_and_add() warn: missing error code 'ret'
drivers/gpu/drm/i915/gvt/gvt.c:365 intel_gvt_init_device() warn: missing error code 'ret'
drivers/gpu/drm/i915/gt/selftest_lrc.c:2683 create_gang() warn: missing error code 'err'
drivers/ata/libata-pmp.c:980 sata_pmp_eh_recover() warn: missing error code 'rc'
drivers/nvme/host/core.c:659 nvme_configure_directives() warn: missing error code 'ret'
drivers/nvme/host/tcp.c:1952 nvme_tcp_setup_ctrl() warn: missing error code 'ret'
drivers/nvme/host/fc.c:3088 nvme_fc_create_association() warn: missing error code 'ret'
drivers/leds/leds-is31fl32xx.c:388 is31fl32xx_parse_dt() warn: missing error code 'ret'
drivers/scsi/ufs/ufshcd-crypto.c:167 ufshcd_hba_init_crypto_capabilities() warn: missing error code 'err'
drivers/scsi/3w-xxxx.c:2312 tw_probe() warn: missing error code 'retval'
drivers/scsi/mpt3sas/mpt3sas_scsih.c:6877 _scsih_expander_add() warn: missing error code 'rc'
drivers/scsi/qedf/qedf_main.c:3042 qedf_alloc_global_queues() warn: missing error code 'status'
drivers/scsi/pcmcia/fdomain_cs.c:49 fdomain_probe() warn: missing error code 'ret'
drivers/scsi/qedi/qedi_main.c:1661 qedi_alloc_global_queues() warn: missing error code 'status'
drivers/scsi/smartpqi/smartpqi_init.c:1209 pqi_get_raid_map() warn: missing error code 'rc'
drivers/block/rsxx/core.c:872 rsxx_pci_probe() warn: missing error code 'st'
drivers/xen/xenbus/xenbus_comms.c:362 process_writes() warn: missing error code 'err'
drivers/xen/unpopulated-alloc.c:43 fill_list() warn: missing error code 'ret'
drivers/platform/x86/toshiba_acpi.c:2834 toshiba_acpi_setup_keyboard() warn: missing error code 'error'
drivers/visorbus/visorchipset.c:1588 visorchipset_init() warn: missing error code 'err'
drivers/pci/controller/dwc/pcie-kirin.c:216 kirin_pcie_clk_ctrl() warn: missing error code 'ret'
drivers/fpga/machxo2-spi.c:229 machxo2_write_init() warn: missing error code 'ret'
drivers/fpga/machxo2-spi.c:316 machxo2_write_complete() warn: missing error code 'ret'
drivers/infiniband/hw/cxgb4/qp.c:298 create_qp() warn: missing error code 'ret'
drivers/infiniband/hw/hfi1/qsfp.c:741 get_cable_info() warn: missing error code 'ret'
drivers/infiniband/hw/mlx4/qp.c:1103 create_qp_common() warn: missing error code 'err'
drivers/infiniband/hw/mlx5/devx.c:1972 mlx5_ib_handler_MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT() warn: missing error code 'err'
drivers/infiniband/core/device.c:709 add_client_context() warn: missing error code 'ret'
drivers/ntb/test/ntb_msi_test.c:373 ntb_msit_probe() warn: missing error code 'ret'
drivers/ntb/test/ntb_perf.c:602 perf_setup_inbuf() warn: missing error code 'ret'
drivers/bluetooth/btusb.c:4788 btusb_resume() warn: missing error code 'err'
drivers/media/platform/meson/ge2d/ge2d.c:991 ge2d_probe() warn: missing error code 'ret'
drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c:155 sun6i_video_start_streaming() warn: missing error code 'ret'
drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c:483 sun6i_video_open() warn: missing error code 'ret'
drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:829 c8sectpfe_probe() warn: missing error code 'ret'
drivers/media/platform/davinci/vpbe.c:632 vpbe_initialize() warn: missing error code 'ret'
drivers/media/platform/qcom/camss/camss-video.c:964 msm_video_register() warn: missing error code 'ret'
drivers/iio/dac/ti-dac5571.c:353 dac5571_probe() warn: missing error code 'ret'
drivers/iio/magnetometer/bmc150_magn.c:794 bmc150_magn_data_rdy_trigger_set_state() warn: missing error code 'ret'
drivers/mcb/mcb-parse.c:88 chameleon_parse_gdd() warn: missing error code 'ret'
arch/x86/oprofile/../../../drivers/oprofile/oprof.c:68 oprofile_setup() warn: missing error code 'err'
drivers/net/wireless/ath/ath10k/pci.c:3700 ath10k_pci_probe() warn: missing error code 'ret'
drivers/net/wireless/ath/ath10k/mac.c:4995 ath10k_start() warn: missing error code 'ret'
drivers/net/wireless/ath/ath10k/mac.c:5493 ath10k_add_interface() warn: missing error code 'ret'
drivers/net/wireless/ath/ath6kl/wmi.c:2508 ath6kl_wmi_sync_point() warn: missing error code 'ret'
drivers/net/wireless/rsi/rsi_91x_usb.c:819 rsi_probe() warn: missing error code 'status'
drivers/net/wireless/intel/ipw2x00/ipw2100.c:753 ipw2100_hw_send_command() warn: missing error code 'err'
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3760 mlxsw_sp_nexthop_group_refresh() warn: missing error code 'err'
drivers/net/ethernet/mellanox/mlx4/main.c:3532 mlx4_load_one() warn: missing error code 'err'
drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:59 mlx5e_tx_reporter_err_cqe_recover() warn: missing error code 'err'
drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:79 mlx5e_rx_reporter_err_icosq_cqe_recover() warn: missing error code 'err'
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2567 mlx5_devlink_eswitch_inline_mode_set() warn: missing error code 'err'
drivers/net/ethernet/mellanox/mlx5/core/main.c:1198 mlx5_load_one() warn: missing error code 'err'
drivers/net/ethernet/sfc/falcon/efx.c:2389 ef4_reset_up() warn: missing error code 'rc'
drivers/net/ethernet/sfc/efx_common.c:757 efx_reset_up() warn: missing error code 'rc'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:1228 bnx2x_iov_init_one() warn: missing error code 'err'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:2673 bnx2x_nic_load() warn: missing error code 'rc'
drivers/net/ethernet/broadcom/bnx2.c:8253 bnx2_init_board() warn: missing error code 'rc'
drivers/net/ethernet/altera/altera_tse_main.c:1443 altera_tse_probe() warn: missing error code 'ret'
drivers/net/ethernet/netronome/nfp/crypto/tls.c:527 nfp_net_tls_rx_resync_req() warn: missing error code 'err'
drivers/net/ethernet/intel/i40e/i40e_main.c:14644 i40e_init_recovery_mode() warn: missing error code 'err'
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:3818 myri10ge_probe() warn: missing error code 'status'
drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:645 tc_setup_taprio() warn: missing error code 'ret'
drivers/net/ethernet/tehuti/tehuti.c:2047 bdx_probe() warn: missing error code 'err'
drivers/net/ethernet/qlogic/qla3xxx.c:3508 ql_adapter_up() warn: missing error code 'err'
drivers/net/ethernet/qlogic/qed/qed_main.c:1293 qed_slowpath_start() warn: missing error code 'rc'
drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1526 cxgb4_port_mirror_alloc() warn: missing error code 'ret'
drivers/thermal/samsung/exynos_tmu.c:1076 exynos_tmu_probe() warn: missing error code 'ret'
drivers/perf/arm_dmc620_pmu.c:684 dmc620_pmu_device_probe() warn: missing error code 'ret'
drivers/hv/connection.c:233 vmbus_connect() warn: missing error code 'ret'
drivers/acpi/apei/erst.c:1114 erst_init() warn: missing error code 'rc'
drivers/extcon/extcon-axp288.c:228 axp288_handle_chrg_det_event() warn: missing error code 'ret'
samples/vfio-mdev/mdpy-fb.c:135 mdpy_fb_probe() warn: missing error code 'ret'
net/sctp/socket.c:8801 sctp_wait_for_packet() warn: missing error code 'error'
net/core/rtnetlink.c:4848 rtnl_bridge_notify() warn: missing error code 'err'

--E/DnYTRukya0zdZ1--
