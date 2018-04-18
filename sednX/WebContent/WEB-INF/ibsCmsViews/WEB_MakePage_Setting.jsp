<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="form_div" id="settingForm" style="max-height: 820px; overflow-y: auto; width:100%;">

        <div class="modal modal-dialog" style="display: block; overflow-y: visible; overflow: visible;">
            <div class="modal-content">
                <div class="modal-header" style="border-bottom: none;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:#000; opacity: 1; position:absolute; top:-10px; right:-5px; background:#fff; border-radius: 10px !important; width: 20px;height: 20px; z-index:1;">
                        ×
                    </button>
                </div>
                <div class="modal-body col-md-12" style="padding: 30px; overflow: hidden;">
                    <div class="col-md-12">
                        <div class="m-b-15 col-md-2" style="top: 5px;">
                            <label class="checkbox-inline">
                                <span class="checkableBox">
                                    <input type="checkbox" class="validate[minCheckbox[2]]" name="group[group]" id="inlineCheckbox1" value="option1"> 
                                </span>
                                제목 :
                            </label>
                        </div>
                        <div class="col-md-10">
                            <input type="text" class="form-control input-sm" value="메인배너" />
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="m-b-15 col-md-2" style="top: 5px;">
                            <label class="checkbox-inline">
                                <span class="checkableBox">
                                    <input type="checkbox" class="validate[minCheckbox[2]]" name="group[group]" id="inlineCheckbox1" value="option1"> 
                                </span>
                                링크 :
                            </label>
                        </div>
                        <div class="col-md-5">
                            <input type="text" class="form-control input-sm" disabled />
                        </div>
                        <div class="col-md-5">
                            <select class="form-control input-sm" disabled>
                                <option>메인페이지</option>
                                <option></option>
                                <option></option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="m-b-15 col-md-2" style="top: 5px; left: 25px;">
                            타입 :
                        </div>
                        <div class="col-md-5">
                            <select class="form-control input-sm" >
                                <option>배너타입</option>
                                <option></option>
                                <option></option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <div class="col-md-3" style="top: 5px;">
                                높이 :
                            </div>
                            <div class="col-md-5">
                                <select class="form-control input-sm" >
                                    <option>50</option>
                                    <option></option>
                                    <option></option>
                                </select>
                            </div>
                            <div class="col-md-4" style="padding: 0;">
                                <select class="form-control input-sm" >
                                    <option>%</option>
                                    <option></option>
                                    <option></option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12 m-t-20 m-b-15 p-20" style="border: 1px solid rgba(255, 255, 255, 0.5); width: calc(100% - 29px); left: 15px;">
                        <p style="position: absolute; top: -11px; background: #202932; padding: 0 10px;">게시판 선택</p>
                        <div class="col-md-4 m-b-15">
                            <select class="form-control input-sm">
                                <optgroup label="Toyota">
                                    <option>Grouped</option>
                                    <option>Toyota Avalon</option>
                                    <option>Toyota Crown</option>
                                    <option>Toyota FT86 </option>
                                </optgroup>
                                 <optgroup label="Lexus">
                                    <option>Lexus LS600</option>
                                    <option>Lexus LFA</option>
                                    <option>Lexus LX570</option>
                                </optgroup>
                            </select>
                        </div>
                        <div class="col-md-3 m-b-15">
                            <button class="btn btn-sm">게시판 추가</button>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="m-b-15 col-md-2" style="top: 5px;">
                            게시 형식 :
                        </div>
                        <div class="col-md-5">
                            <select class="form-control input-sm" >
                                <option>선택된 게시물을</option>
                                <option></option>
                                <option></option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <select class="form-control input-sm">
                                <option>최신순으로</option>
                                <option></option>
                                <option></option>
                            </select>
                        </div>
                    </div>

                </div>
                <div class="clearfix"></div>
            </div>
        </div>

       
    </div>
    <div class="tile col-md-12 p-5">
       <div class="col-md-6">
           <button class="btn btn-alt col-md-2 m-b-5">추가</button>
       </div>
       <div class="col-md-6">
           <button class="btn btn-alt col-md-2 m-b-5 pull-right">적용</button>
       </div>
   </div>

